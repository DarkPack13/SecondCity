> This is for server maints rather then contributers

Hello downstream! A little guide here for someone setting up a downstream.

## The modular folder
I have made this sample directory here with all the requiste things for linters and build tools to recongize a folder.
You could theorticly operate out of this folder as is but I would recommend renaming it to your respetive downstream

for servers with names that are ordered before darkpack (like apoc), I recommend appending a z, (modular_zapoc for example). This ensures the build order is sane.

If you want to rename this directory, you will need to make changes to the following:
Non-modular files
`tools/ticked_file_enforcement/schemas/modular_downstream.json`
Non-modular edits to files
`.github/workflows/run_linters.yml`
`tools/build/build.ts`
`tools/deploy.sh`
`code/controllers/subsystem/sounds.dm`

## Other tips
If your confused why your actions are not running. You need to add a repo sercet to your github called `ACTION_ENABLER`. Any value inside of it will work.

I highly recommend copying the darkpack moduarity guide and find and replace darkpack with your own module id/comment (I've used `DOWNSTREAM EDIT` for the above files)
