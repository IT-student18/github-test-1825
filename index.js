const readline = require('readline');

// Create a simple input function
function input(prompt) {
  const rl = readline.createInterface({
    input: process.stdin,
    output: process.stdout
  });

  return new Promise((resolve) => {
    rl.question(prompt, (answer) => {
      rl.close(); // Clean up
      resolve(answer);
    });
  });
}

// Example: Assign input to a variable
// async function main() {
//   const name = await input("Enter your name: ");
//   console.log("Hello,", name);
// }

// main();

const sleep = (ms) => new Promise(resolve => setTimeout(resolve, ms));

async function main() {
  let u = 9;
  let a = 10;
  console.log("Quessa 9 plus 10 égale?");
  let answ = await input("Réponse: ");
  if (answ === "19") {
      console.log("NON! c'est PAS ça!");
      await sleep(1000);
      
      answ = await input("Options:\n"+"1 - Que-ce qu'est c'est ça puis?\n"+"2- oke, ça me derange pas\n"+"Réponse:");
      if (answ === "1") {
        console.log("C'est...");
        await sleep(2000);
        console.log("21");
        await sleep(2000);
        console.log("mon gar.");
        } else if (answ === "2") {
            await sleep(3000);
            console.log("Bien pour toi.");
        }
    } else if (answ === "21") {
            console.log("Bien sur mec! Bien sur :D");
        }
    answ = await input("press enter to exit.");

}

main();