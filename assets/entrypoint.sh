#!/bin/bash

TEMPLATE_FILE=/tika-config.template.xml
GENERATE_FILE=/tika-config.xml
GENERATE_DATE=$(date -u +"%Y-%m-%dT%H:%M:%SZ")

sed "s/GENERATE_DATE/${GENERATE_DATE}/g" ${TEMPLATE_FILE} | \
    sed "s/TIKA_TEXT_CSV_CONFIDENCE/${TIKA_TEXT_CSV_CONFIDENCE:-0.5}/g" | \
    sed "s/TIKA_HTML_EXTRACT_SCRIPTS/${TIKA_HTML_EXTRACT_SCRIPTS:-false}/g" | \
    sed "s/TIKA_OFFICE_EXTRACT_MACROS/${TIKA_OFFICE_EXTRACT_MACROS:-false}/g" | \
    sed "s/TIKA_OFFICE_INCLUDE_DELETED_CONTENT/${TIKA_OFFICE_INCLUDE_DELETED_CONTENT:-false}/g" | \
    sed "s/TIKA_OFFICE_INCLUDE_MOVED_CONTENT/${TIKA_OFFICE_INCLUDE_MOVED_CONTENT:-false}/g" | \
    sed "s/TIKA_OFFICE_INCLUDE_SHAPE_CONTENT/${TIKA_OFFICE_INCLUDE_SHAPE_CONTENT:-false}/g" | \
    sed "s/TIKA_OFFICE_INCLUDE_HEADER_FOOTER/${TIKA_OFFICE_INCLUDE_HEADER_FOOTER:-true}/g" | \
    sed "s/TIKA_OFFICE_INCLUDE_MISSING_ROWS/${TIKA_OFFICE_INCLUDE_MISSING_ROWS:-false}/g" | \
    sed "s/TIKA_OFFICE_INCLUDE_SLIDE_NOTES/${TIKA_OFFICE_INCLUDE_SLIDE_NOTES:-true}/g" | \
    sed "s/TIKA_OFFICE_INCLUDE_SLIDE_MASTER/${TIKA_OFFICE_INCLUDE_SLIDE_MASTER:-true}/g" | \
    sed "s/TIKA_OFFICE_INCLUDE_PHONETIC/${TIKA_OFFICE_INCLUDE_PHONETIC:-false}/g" | \
    sed "s/TIKA_OFFICE_USE_SAX_EXTRACTOR/${TIKA_OFFICE_USE_SAX_EXTRACTOR:-true}/g" | \
    sed "s/TIKA_OFFICE_DATE_OVERRIDE_FORMAT/${TIKA_OFFICE_DATE_OVERRIDE_FORMAT:-dd-mm-yyyy}/g" | \
    sed "s/TIKA_TESSERACT_OCR_LANGUAGE/${TIKA_TESSERACT_OCR_LANGUAGE:-eng+tur+rus+ara+chi_sim+kor+jpn+kat+grc+heb+hin}/g" | \
    sed "s/TIKA_TESSERACT_OCR_TIMEOUT/${TIKA_TESSERACT_OCR_TIMEOUT:-120}/g" | \
    sed "s/TIKA_TESSERACT_OCR_AUTO_ROTATE/${TIKA_TESSERACT_OCR_AUTO_ROTATE:-false}/g" | \
    sed "s/TIKA_PDF_INCLUDE_BOOKMARK/${TIKA_PDF_INCLUDE_BOOKMARK:-false}/g" | \
    sed "s/TIKA_PDF_INCLUDE_ANNOTATION/${TIKA_PDF_INCLUDE_ANNOTATION:-false}/g" | \
    sed "s/TIKA_PDF_OCR_STRATEGY/${TIKA_PDF_OCR_STRATEGY:-auto}/g" > ${GENERATE_FILE}

echo "Config generation finished. ${GENERATE_FILE}"
echo "--------------------------"
cat ${GENERATE_FILE}
echo "--------------------------"

java -jar /tika-server-standard-2.0.0.jar -h 0.0.0.0 -p 9998 --config ${GENERATE_FILE}
