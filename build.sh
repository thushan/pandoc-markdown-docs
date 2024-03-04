#!/usr/bin/env bash
#####
# Pandoc Build Script
# github.com/thushan/
#####
CODE_STYLE=zenburn
CBlue=$(tput setaf 4)
CYellow=$(tput setaf 3)
ENDMARKER=$(tput sgr0)

SOURCE=${1:-review.md}
OUTPUT=${2}
TEMPLATE=${3:-template/template-full.docx}

if [[ ! -x "$(command -v pandoc)" ]]; then

	echo "Please install ${CYellow}pandoc${ENDMARKER} to continue"
	echo ""

	if [[ "$OSTYPE" =~ ^linux ]]; then		
		echo "$ ${CBlue}apt get install pandoc${ENDMARKER}"
	fi

	if [[ "$OSTYPE" =~ ^darwin ]]; then
		echo "$ ${CBlue}brew install pandoc${ENDMARKER}"
	fi

	if [[ "$OSTYPE" =~ ^msys ]]; then
		echo "$ ${CBlue}choco install pandoc${ENDMARKER}"
	fi
	exit 1
fi

if [[ -z "$OUTPUT" ]]; then
    filename=$(basename -- "$SOURCE")
    OUTPUT="${filename%.*}-draft.docx"
fi

pandoc --toc --reference-doc "$TEMPLATE" \
		-o "$OUTPUT" \
		--highlight-style "$CODE_STYLE" \
		--from=markdown+grid_tables \
		"$SOURCE"
