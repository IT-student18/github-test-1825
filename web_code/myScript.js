if (document.readyState === 'loading') {
  await new Promise(resolve => document.addEventListener('DOMContentLoaded', resolve));
}

const sleep = (ms) => new Promise(resolve => setTimeout(resolve, ms))
const elt = document.getElementById("eq");
let a = 0;
while (true) {
a +=1;
elt.innerText = a.toString();
await sleep(1000);
}




