# This exists because Cabbage Audio's bundling opcode doesn't work for some reason
# Run this program as sudo so that it can package CSound64 with the Audio Unit if building an OS X plugin

cp -r ${1} "${2}/Contents"
find "${2}/Contents" -name "*.xcf" -type f -delete

if [[ ${2} == *.component ]]; then
    cp -r "/Library/Frameworks/CsoundLib64.framework" "${2}/Contents/Resources"
    cd "${2}/Contents/Resources/CsoundLib64.framework"
    install_name_tool -id "@rpath/CsoundLib64.framework/CsoundLib64" CsoundLib64
    cd ../../MacOS
    install_name_tool -change /Library/Frameworks/CsoundLib64.framework/CsoundLib64 @loader_path/../Resources/CsoundLib64.framework/CsoundLib64 CabbagePluginEffect
fi