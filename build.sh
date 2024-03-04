#!/usr/bin/env bash
#####
# Pandoc Build Script
# github.com/thushan/pandoc-markdown-docs
#####
CODE_STYLE=zenburn
CBlue=$(tput setaf 4)
CYellow=$(tput setaf 3)
CGreen=$(tput setaf 2)
CRed=$(tput setaf 1)
ENDMARKER=$(tput sgr0)

SOURCE=${1:-readme.md}
OUTPUT=${2}
TEMPLATE=${3:-template/template.docx}

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

if [[ ! -f "$TEMPLATE" ]]; then
	echo "${CRed}Template file ${CYellow}$TEMPLATE${ENDMARKER}${CRed} not found${ENDMARKER} :-("
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
		
if [[ -f "$OUTPUT" ]]; then
	echo "${CGreen}Document ${CYellow}$OUTPUT${ENDMARKER}${CGreen} created successfully${ENDMARKER} :-)"
else
	echo "${CRed}Document ${CYellow}$OUTPUT${ENDMARKER}${CRed} was not created${ENDMARKER} :-("
fi