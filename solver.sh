#!/usr/bin/env bash
# solve_agent_quiz.sh - Automated solver for Agent Quiz
# Usage: ./solve_agent_quiz.sh

BINARY="./agent_quiz"

if [ ! -x "$BINARY" ]; then
    printf "[ERROR] %s not found or not executable. Compile first.\n" "$BINARY"
    printf "  gcc -O2 -o agent_quiz agent_quiz.c -Wall -Wextra\n"
    exit 1
fi

# The real product key (as embedded in the challenge source)
PRODUCT_KEY="C7T-AG3NT-K3Y-VAULT"

# Dummy answers (any appropriate text will work)
ANS1="Shadow"
ANS2="Berlin"
ANS3="AES"
ANS4="JD"
ANS5="2021"
ANS6="Omega"

# Feed answers into the program (zsh-safe printf)
{
    printf "%s\n" "$ANS1"
    printf "%s\n" "$ANS2"
    printf "%s\n" "$ANS3"
    printf "%s\n" "$ANS4"
    printf "%s\n" "$ANS5"
    printf "%s\n" "$ANS6"
    printf "%s\n" "$PRODUCT_KEY"
} | "$BINARY" | tee solve_output.txt

printf "\n=====================================\n"
printf "[+] Done. Checking for flag...\n"
if grep -q "FLAG:" solve_output.txt; then
    grep "FLAG:" solve_output.txt
else
    printf "[-] Flag not found. Inspect solve_output.txt\n"
fi
