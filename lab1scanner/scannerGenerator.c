#include <stdio.h>
#include <ctype.h>
#include <string.h>
#include <stdlib.h>

int total_int = 0;
int total_float = 0;
int total_id = 0;
int total_error = 0;

int isInteger(char *str) {
    if (str[0] == '+' || str[0] == '-') str++;
    if (*str == '\0') return 0;
    while (*str) {
        if (!isdigit(*str)) return 0;
        str++;
    }
    return 1;
}

int isFloat(char *str) {
    int has_dot = 0;
    int has_digit_before_dot = 0;
    int has_digit_after_dot = 0;
    if (str[0] == '+' || str[0] == '-') str++;
    if (*str == '\0') return 0;
    while (*str) {
        if (*str == '.') {
            if (has_dot) return 0;
            has_dot = 1;
        } else if (isdigit(*str)) {
            if (!has_dot) {
                has_digit_before_dot = 1;
            } else {
                has_digit_after_dot = 1;
            }
        } else {
            return 0;
        }
        str++;
    }
    return has_dot && has_digit_before_dot && has_digit_after_dot;
}

int isIdentifier(char *str) {
    if (!isalpha(str[0])) return 0;
    str++;
    while (*str) {
        if (!isalnum(*str) && *str != '_') return 0;
        str++;
    }
    return 1;
}

void classifyToken(char *token) {
    if (isInteger(token)) {
        printf("Integer : %s\n", token);
        total_int++;
    } else if (isFloat(token)) {
        printf("Float : %s\n", token);
        total_float++;
    } else if (isIdentifier(token)) {
        printf("Identifier(ID) : %s\n", token);
        total_id++;
    } else {
        printf("Error : %s\n", token);
        total_error++;
    }
}

int main(int argc, char *argv[]) {
    if (argc != 2) {
        printf("Usage: %s <filename>\n", argv[0]);
        return 1;
    }

    FILE *file = fopen(argv[1], "r");
    if (file == NULL) {
        printf("Error opening file: %s\n", argv[1]);
        return 1;
    }

    char line[256];

    while (fgets(line, sizeof(line), file)) {
        line[strcspn(line, "\n")] = 0;

        char *start = line;
        while (isspace(*start)) start++;
        char *end = start + strlen(start) - 1;
        while (end > start && isspace(*end)) *end-- = '\0';


        if (*start == '\0') continue;

        if (strchr(start, ' ') != NULL || strchr(start, ';') != NULL) {
            printf("Error : %s\n", start);
            total_error++;
        } else {
            classifyToken(start);
        }
    }

    fclose(file);

    printf("\nTotal_Integer : %d\n", total_int);
    printf("Total_Float : %d\n", total_float);
    printf("Total_Identifier(ID) : %d\n", total_id);
    printf("Total_Error : %d\n", total_error);

    return 0;
}
