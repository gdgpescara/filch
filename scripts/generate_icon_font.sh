#!/usr/bin/env sh

set -e # Exit on first failed command

# Variables
CLASS_NAME="AppIcons"
FONT_NAME="AppIcons.ttf"
FILE_NAME="app_icons.dart"
ICONS_DIR="assets/svg_icons"
DART_FILE_OUTPUT_PATH="lib/theme/"
FONT_FILE_OUTPUT_PATH="assets/fonts/"

PART_IMPORT="part of \'app_theme.dart\'\;"
REMOVE_IMPORT="import \'package:flutter\/widgets.dart\'\;"

FILE_NAME_CLEAN="${FILE_NAME}-e"

flutter pub global activate icon_font_generator

# Generate icons
flutter pub global run icon_font_generator --from=$ICONS_DIR --class-name=$CLASS_NAME --out-font=$FONT_FILE_OUTPUT_PATH$FONT_NAME --out-flutter=$DART_FILE_OUTPUT_PATH$FILE_NAME --normalize

# Add part of theme
sed -i -e "s/${REMOVE_IMPORT}/${PART_IMPORT}/g" $DART_FILE_OUTPUT_PATH$FILE_NAME

# clean
rm $DART_FILE_OUTPUT_PATH$FILE_NAME_CLEAN
