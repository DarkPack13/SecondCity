#!/bin/bash

#ANSI Escape Codes for colors to increase contrast of errors
RED="\033[0;31m"
GREEN="\033[0;32m"
BLUE="\033[0;34m"
NC="\033[0m" # No Color

echo -e "${BLUE}Re-running grep checks, but looking in zapoc_darkpack...${NC}"

# Run the linters again, but modular DarkPack13 code.
sed "s|code/\*\*/\*\.dm|zapoc_darkpack/\*\*/\*\.dm|g" <tools/ci/check_grep.sh | bash
