const fs = require('fs');
const html = fs.readFileSync('index.html', 'utf8');
const voids = new Set(['area','base','br','col','embed','hr','img','input','link','meta','param','source','track','wbr']);
const tagRe = /<!--([\s\S]*?)-->|<\/?([A-Za-z][A-Za-z0-9:-]*)([^>]*)>/g;
const stack = [];
const errors = [];
let m;
while ((m = tagRe.exec(html))) {
  if (m[1]) continue;
  const tag = m[2] && m[2].toLowerCase();
  if (!tag) continue;
  const isClose = m[0].startsWith('</');
  const attrs = m[3] || '';
  const selfClose = /\/$/.test(attrs) || voids.has(tag);
  if (isClose) {
    if (stack.length === 0) {
      errors.push(`Extra closing </${tag}> at index ${m.index}`);
      continue;
    }
    const last = stack.pop();
    if (last !== tag) {
      errors.push(`Mismatched closing </${tag}> at index ${m.index}, expected </${last}>`);
    }
  } else if (!selfClose) {
    stack.push(tag);
  }
}
if (stack.length) {
  console.log('Unclosed tags:');
  stack.forEach((t) => console.log(t));
}
if (errors.length) {
  console.log('Errors:');
  errors.forEach((e) => console.log(e));
}
if (!stack.length && !errors.length) {
  console.log('OK');
}
