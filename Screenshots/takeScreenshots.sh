#!/bin/sh

pushd "$(dirname $0)/.."

xcodebuild build test -workspace 'RealmToDo.xcworkspace' -scheme 'Screenshot DE' -destination name='iPhone 6' -destination name='iPhone 6 Plus' -destination name='iPhone 5' -destination name='iPhone 4s'
xcodebuild build test -workspace 'RealmToDo.xcworkspace' -scheme 'Screenshot EN' -destination name='iPhone 6' -destination name='iPhone 6 Plus' -destination name='iPhone 5' -destination name='iPhone 4s'
popd
