//1 - 100 которые делятся без остатка 2 и 3 или 5
// let TargetedNumbs = "";
// for (let a =0; a<101; a++) {
//     if ( ( (a%2===0) && (a%3===0) ) || (a%5===0) ) { TargetedNumbs += "," + String(a)} else continue;
// }
// console.log(TargetedNumbs);

// let a = "ConstructionWorker";
// for (let char in a) {await setTimeout(() => {console.log(a[char]);}, 1000);
// }

// let Me = {
//     Имя: "Василий",
//     Фамилия: "Мельников",
//     Отчество: "Алексеевич"
// };
// console.log(Me["Имя"], Me["Отчество"]);
const ch = "#";
let f = [...(ch.repeat(3))].repeat(3);
console.log(f.join(''));