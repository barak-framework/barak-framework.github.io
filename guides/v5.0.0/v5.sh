#!/bin/bash

filenames=$(grep -rl "redirect_to" app/controllers/*);
for filename in $filenames; do
sed -i 's/redirect_to("\//redirect_to("/g' $filename;
done

filename=config/routes.php;

sed -i 's/get("\//get("/g' $filename;
sed -i 's/post("\//post("/g' $filename;
sed -i 's/scope("\//scope("/g' $filename;
sed -i 's/resource("\//resource("/g' $filename;
sed -i 's/resources("\//resources("/g' $filename;

filenames=$(grep -rl "render" app/controllers/*);
for filename in $filenames; do
sed -i 's/render("\//render("/g' $filename;
done          
