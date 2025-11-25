const fs = require("node:fs");

let list_1 = [3, 4, 2, 1, 3, 3];
let list_2 = [4, 3, 5, 3, 9, 3];

fs.readFile("../input", "utf8", (err, data) => {
  if (err) {
    console.error(err);
    return;
  }
  const all = data.match(/[0-9]+/g);

  list_1 = [];
  list_2 = [];

  all.forEach((n, i) => {
    if (i % 2 === 0) {
      list_1.push(n);
    } else {
      list_2.push(n);
    }
  });

  const sortedList_1 = list_1.sort((a, b) => a - b);
  const sortedList_2 = list_2.sort((a, b) => a - b);

  let similarityScore = 0;
  let similarityList = {};

  list_1.forEach((n1) => {
    list_2.forEach((n2) => {
      if (n1 === n2) {
        if (!similarityList[n1]) {
          similarityList[n1] = 1;
        } else {
          similarityList[n1] += 1;
        }
      }
    });
  });

  for (const [key, value] of Object.entries(similarityList)) {
    similarityScore += Number(key) * value;
  }

  console.log(similarityScore);
});
