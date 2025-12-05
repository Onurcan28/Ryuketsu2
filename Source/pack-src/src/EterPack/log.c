#include "log.h"

char log_dir[256], sys_log_header_string[32]; // SIZE TO CHECK
SUnkStruct1 *log_file_sys = NULL, *log_file_err = NULL, *log_file_pt = NULL;
unsigned int log_level_bits = 0;
int log_keep_days = 365;

void log_set_level(int a1)
{
    log_level_bits |= a1;
}

void log_unset_level(int a1)
{
    log_level_bits &= ~a1;
}

void log_set_expiration_days(int a1)
{
    log_keep_days = a1;
}

int log_get_expiration_days(void)
{
    return log_keep_days;
}

void sys_log_header(const char *src)
{
    strncpy(sys_log_header_string, src, 32);
}

void log_file_destroy(SUnkStruct1 *ptr)
{
    if(ptr->Unk0)
    {
        free(ptr->Unk0);
        ptr->Unk0 = 0;
    }

    if(ptr->Unk4)
    {
        fclose(ptr->Unk4);
        ptr->Unk4 = 0;
    }

    free(ptr);
}

void log_destroy(void)
{
    log_file_destroy(log_file_sys);
    log_file_destroy(log_file_err);
    //log_file_destroy(log_file_pt);

    log_file_sys = 0;
    log_file_err = 0;
    //log_file_pt = 0;
}

/*FILE *log_file_check(int a1)
{
    FILE *result; // eax@1
    char buf; // [sp+14h] [bp-64h]@1

    result = (FILE *)stat(*(const char **)a1, (struct stat *)&buf);
    if(result)
    {
        result = (FILE *)__error();
        if(result->_flags == 2)
        {
            fclose(*(FILE **)(a1 + 4));
            result = fopen(*(const char **)a1, "a+");
            *(_DWORD *)(a1 + 4) = result;
        }
    }
    return result;
}*/

SUnkStruct1 *log_file_init(const char *s, const char *modes)
{
    SUnkStruct1 *v2; // ebx@1
    struct tm *v3; // eax@1
    int v4; // edi@1
    FILE *v5; // esi@1
    int v8; // [sp+8h] [bp-20h]@1
    time_t timer; // [sp+18h] [bp-10h]@1

    v2 = 0;
    timer = time(0);
    v3 = localtime(&timer);
    v4 = v3->tm_hour;
    v8 = v3->tm_mday;
    v5 = fopen(s, modes);

    if(v5)
    {
        v2 = (SUnkStruct1 *)malloc(sizeof(SUnkStruct1));

        v2->Unk4 = v5;
        v2->Unk8 = v4;
        v2->Unk0 = strdup(s);
        v2->Unk12 = v8;
    }

    return v2;
}

void pt_log(const char *format, ...)
{
    va_list va; // [sp+34h] [bp+Ch]@1

    va_start(va, format);

    if(log_file_pt)
    {
        vfprintf(log_file_pt->Unk4, format, va);
        fputc(10, log_file_pt->Unk4);
        fflush(log_file_pt->Unk4);
    }
}

void sys_log(int a1, const char *format, ...)
{
    char *v4; // ebx@4
    time_t timer; // [sp+18h] [bp-10h]@4
    va_list va; // [sp+38h] [bp+10h]@1

    va_start(va, format);
    if(!a1 || a1 & log_level_bits)
    {
        if(log_file_sys)
        {
            timer = time(0);
            v4 = asctime(localtime(&timer));

            fprintf(log_file_sys->Unk4, sys_log_header_string);
            v4[strlen(v4) - 1] = 0;

            fprintf(log_file_sys->Unk4, "%-15.15s :: ", v4 + 4);
            vfprintf(log_file_sys->Unk4, format, va);
            fputc(10, log_file_sys->Unk4);
            fflush(log_file_sys->Unk4);

            if(log_level_bits > 1)
            {
                fprintf(stdout, sys_log_header_string);
                vfprintf(stdout, format, va);
                fputc(10, stdout);
                fflush(stdout);
            }
        }
    }
}

void log_file_set_dir(const char *src)
{
    strcpy(log_dir, src);
}

bool log_init(void)
{
#ifdef _MSC_VER
	CHAR szFullPath[MAX_PATH];
#endif

#ifdef _MSC_VER
    log_file_set_dir("./");
#else
	log_file_set_dir("./log");
#endif

#ifdef _MSC_VER
	GetModuleDirectory(MAX_PATH, szFullPath);
	strncat(szFullPath, "\\syslog.txt", MAX_PATH);

    log_file_sys = log_file_init(szFullPath, "a+");
#else
	log_file_sys = log_file_init("syslog", "a+");
#endif

#ifdef _MSC_VER
	GetModuleDirectory(MAX_PATH, szFullPath);
	strncat(szFullPath, "\\syserr.txt", MAX_PATH);

    if(log_file_sys && (log_file_err = log_file_init(szFullPath, "a+")) != 0)
#else
	if(log_file_sys && (log_file_err = log_file_init("syserr", "a+")) != 0)
#endif
    {
#ifdef __LOG_PT
        log_file_pt = log_file_init("PTS", "w");
        return log_file_pt != 0;
#else
		return true;
#endif
    }

    return false;
}

void sys_err(char *a1, int a2, const char *format, ...)
{
    char *result; // eax@1
    int v5; // eax@2
    char s[1026]; // [sp+1Ah] [bp-40Eh]@2
    time_t timer; // [sp+41Ch] [bp-Ch]@1
    va_list va; // [sp+43Ch] [bp+14h]@1

    va_start(va, format);
    timer = time(0);
    result = asctime(localtime(&timer));

    if(log_file_err)
    {
        result[strlen(result) - 1] = 0;

#ifdef _MSC_VER
		v5 = _snprintf(s, 0x400u, "SYSERR: %-15.15s :: %s: ", result + 4, a1);
#else
		v5 = snprintf(s, 0x400u, "SYSERR: %-15.15s :: %s: ", result + 4, a1);
#endif
        
        s[1025] = 0;

        if(v5 <= 1023)
            vsnprintf(&s[v5], 1024 - v5, format, va);

        *(short *)&s[strlen(s)] = 10;

        fputs(s, log_file_err->Unk4);
        fflush(log_file_err->Unk4);

        fputs(s, log_file_sys->Unk4);
        fflush(log_file_sys->Unk4);
    }
}
