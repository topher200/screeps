cat src/* | coffee --compile --stdio | tee generated_bundle.js | clip