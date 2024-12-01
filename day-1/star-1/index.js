const fs = require("node:fs");

let list_1 = [3, 4, 2, 1, 3, 3];
let list_2 = [4, 3, 5, 3, 9, 3];

fs.readFile("input", "utf8", (err, data) => {
  if (err) {
    console.error(err);
    return;
  }
  const all = data.match(/[0-9]+/g);

  list_1 = [];
  list_2 = [];

  all.forEach((e, i) => {
    if (i % 2 === 0) {
      list_1.push(e);
    } else {
      list_2.push(e);
    }
  });

  const sortedList_1 = list_1.sort((a, b) => a - b);
  const sortedList_2 = list_2.sort((a, b) => a - b);

  let total_diff = 0;

  for (let i = 0; i < list_1.length; i++) {
    total_diff += Math.abs(sortedList_1[i] - sortedList_2[i]);
  }

  console.log(total_diff);
});
