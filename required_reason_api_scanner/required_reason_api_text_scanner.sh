#!/bin/bash

# https://developer.apple.com/documentation/bundleresources/privacy_manifest_files/describing_use_of_required_reason_api
searchTerms=(
    ".creationDate"
    ".creationDateKey"
    ".modificationDate"
    ".fileModificationDate" 
    ".contentModificationDateKey" 
    ".creationDateKey"
    "getattrlist(" 
    "getattrlistbulk(" 
    "fgetattrlist(" 
    "stat.st_" # see https://developer.apple.com/documentation/kernel/stat
    "fstat("
    "fstatat("
    "lstat("
    "getattrlistat("
    "systemUptime"
    "mach_absolute_time()"
    "volumeAvailableCapacityKey"
    "volumeAvailableCapacityForImportantUsageKey"
    "volumeAvailableCapacityForOpportunisticUsageKey"
    "volumeTotalCapacityKey"
    "systemFreeSize"
    "systemSize"
    "statfs("
    "statvfs("
    "fstatfs("
    "fstatvfs("
    "getattrlist("
    "fgetattrlist("
    "getattrlistat("
    "activeInputModes"
    "UserDefaults"
    "NSUserDefaults"
    "NSFileCreationDate"
    "NSFileModificationDate"
    "NSFileSystemFreeSize"
    "NSFileSystemSize"
    "NSURLContentModificationDateKey"
    "NSURLCreationDateKey"
    "NSURLVolumeAvailableCapacityForImportantUsageKey"
    "NSURLVolumeAvailableCapacityForOpportunisticUsageKey"
    "NSURLVolumeAvailableCapacityKey"
    "NSURLVolumeTotalCapacityKey"
)
search_dir="$1"

if [ -z "$search_dir" ]; then
    echo "Usage: $0 <search_dir>"
    exit 1
fi

foundAPIs=()

for pattern in "${searchTerms[@]}"; do
    files=$(find "$search_dir" -type f \
        \( -name "*.swift" -o -name "*.m" -o -name "*.mm" -o -name "*.cpp" -o -name "*.cc" -o -name "*.c" \
        -o -name "*.h" -o -name "*.hpp" -o -name "*.hh" -o -name "*.pch" -o -name "*.s" -o -name "*.metal" \) \
        -exec grep -H -Fw "$pattern" {} +)
    if [[ -n "$files" ]]; then
        foundAPIs+=("$pattern")
        echo "API found: $pattern"
        echo -e "$files\n"
    fi
done

echo "List of found APIs:"
for api in "${foundAPIs[@]}"; do
    echo "- $api"
done
