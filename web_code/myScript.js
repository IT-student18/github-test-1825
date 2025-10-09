// if (document.readyState === 'loading') {
//   await new Promise(resolve => document.addEventListener('DOMContentLoaded', resolve));
// }

// const sleep = (ms) => new Promise(resolve => setTimeout(resolve, ms))
// const elt = document.getElementById("eq");
// let a = 0;
// while (true) {
// a +=1;
// elt.innerText = a.toString();
// await sleep(1000);
// }
//Начало:
// let s = "Home";//присваиваем значение "Home" переменной(кому-чему*) s
// for (i = s.length-1; i>-1; i--){/*запускаем цикл, где: i сначала равна длинне строки s, а цикл прерывается когда i>-1;
//    также: в конце каждой итерации цикла, i уменьшается на 1(если бы было на 2 и более было бы: i-=2..i-=n)*/
//   console.log(`i = ${i}, символ на позиции i: ${s.at(i)}`);//выводим символ s на позиции i.
// }
//(чтобы использовать это(↑) решение, но не с "созданием перевёрнутой строки" -
// надо убрать "//" перед строчкой. А если второй варик - то просто не переписывай этот(и вообще: не переписывай комменты(всё что написано зелёным цветом*)))
//итерации цикла:
// i = 3, символ на позиции i: e
// i = 2, символ на позиции i: m
// i = 1, символ на позиции i: o
// i = 0, символ на позиции i: H
//------код для создания перевёрнутой строки этим методом:
const { stdin, stdout } = process;


n = true;
let s, s2;
const h = [];
async function main() {
  try {
    while (n) {
      s = await prompt("enter str. to continue, just press enter");
      if (s!= "") {h.push(s)} else n = !n;
    }
    console.log(h.join(', '));
    s2 = h;
    h.splice(1, 2);//h = h[{1..2}]
    console.log(s2.join(', '));
    stdin.pause();
  } catch(error) {
    console.log("There's an error!");
    console.log(error);
  }
  process.exit();
}

main();

function prompt(question) {
  return new Promise((resolve, reject) => {
    stdin.resume();
    stdout.write(question);

    stdin.on('data', data => resolve(data.toString().trim()));
    stdin.on('error', err => reject(err));
  });
}




