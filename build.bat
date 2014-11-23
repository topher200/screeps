@echo off

# Remove the 'write completed' part when coffee-stir fixes issue #2
coffee-stir src/main.coffee | sed 's/write completed//g' | coffee --compile --stdio | tee generated_bundle.js | clip