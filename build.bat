@echo off

:: Remove the 'write completed' part when coffee-stir fixes issue #2
set datetime=%date:~-10,2%%date:~-7,2%%date:~-4,4%_%time:~0,2%%time:~3,2%%time:~6,2%
coffee-stir src/main.coffee | sed 's/write completed//' | coffee --compile --stdio | sed 's/insert_version_here/%datetime%/' | tee generated_bundle.js | clip