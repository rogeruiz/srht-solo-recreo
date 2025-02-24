// Creador de archivos NodeJS-XOS :: XOS NodeJS file creator
// Public Domain (CC0) 2025 Roger Steve Ruiz
//
// This program is free software: you can redistribute it and/or modify it
// freely. It is in the public domain within the United States.
//
// The person who associated a work with this deed has dedicated the work to the
// public domain by waiving all of his or her rights to the work worldwide under
// copyright law, including all related and neighboring rights, to the extent
// allowed by law.
//
// You can copy, modify, distribute and perform the work, even for commercial
// purposes, all without asking permission.
//
// In no way are the patent or trademark rights of any person affected by CC0, nor
// are the rights that other persons may have in the work or in how the work is
// used, such as publicity or privacy rights.
//
// Unless expressly stated otherwise, the person who associated a work with this
// deed makes no warranties about the work, and disclaims liability for all uses of
// the work, to the fullest extent permitted by applicable law. When using or
// citing the work, you should not imply endorsement by the author or the affirmer.
//
// You should have received a copy of the CC0 1.0 Universal License along with
// this program. If not, see <https://creativecommons.org/publicdomain/zero/1.0/>.

// NOTE: There are variables that are being set before this file is read in by
// `just new _create`. View that recipe to see the variables being used in this
// file that are not being created.
// es: Hai variables que se estan definado en la receta `just new _create`.
// Toma nota en esa receta pa' ver los variables que se usan en este guion pero
// no se crean aquí.

const fs = require('node:fs');
const path = require('node:path');

const today = new Date().toISOString().split('T')[0];

console.info(`📝 Creating a new ${type} on ${today}`);

console.info(`🔍 Found ${type} title: ${title}`);

const runningFromDir = path.join(normalizedPath);

let fullWritePath;
if (runningFromDir.endsWith(folderPath)) {
  fullWritePath = runningFromDir;
} else {
  fullWritePath = path.join(runningFromDir, folderPath);
}

const isFile = fileName => {
  const re = /[0-9]{4}/g;
  return fs.lstatSync(fileName).isFile() && fileName.match(re);
};

console.info(`🔦 Checking for existing ${type}s in ${fullWritePath}`);

const resolvedPath = path.resolve(fullWritePath);

const template = fs.readFileSync(`${fullWritePath}/.template`)

const files = fs.readdirSync(resolvedPath)
  .map(fileName => {
    return path.join(fullWritePath, fileName);
  })
  .filter(isFile);

console.info(`🔍 Found ${(files.length + "").padStart(4, '0')} ${type}(s)`);

const nextNumber = files.length + 1;
const nextNumberString = (nextNumber + "").padStart(4, '0');

console.info(`🖊️ Setting your new ${type} to #${nextNumberString}`);

const nextFilePath = path.join(
  resolvedPath,
  `${nextNumberString}-${fileTitle}.md`
);

console.info(`📊 Attempting to save ${type} #${nextNumberString} to ${nextFilePath}`);

const content = eval(`\`${template}\``);

try {
  fs.writeFileSync(nextFilePath, content);
  console.log(`✅ Successfully created ${type} #${nextNumberString} for ${title} at ${nextFilePath}`);
} catch (e) {
  console.error(`❌ ${e}`);
}
