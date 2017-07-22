let keypress = require('keypress');
keypress(process.stdin);

// all possible single positions are 2 to the power of i
let POSITIONS = new Uint32Array(32);
for (var i = 0; i < 32; i++) {
  POSITIONS[i] = (Math.pow(2, i));
}

const RIGHTMOST_POSITION = POSITIONS[31];
const LEFTMOST_POSITION = POSITIONS[0];

class Dodger {
  constructor() {
    this.board = new Uint32Array(32);
    this.board.fill(0);
    this.player = POSITIONS[15];
    this.steps = 0;
    this.playing = true;
  }
  
  step() {
    // is the player about to collide with a baddie?
    if ((this.board[31] & this.player) >>> 0 !== 0) {
      this.playing = false;
      return;
    }
    // move all the baddies down one row on the board
    this.board.copyWithin(1, 0, 31);
    this.board[0] = this.generateRow();
    this.steps += 1;
    this.render();
  }
  
  generateRow() {
    let probability = this.steps / 320.0;
    let newRow = 0;
    for (var i = 0; i < 32; i++) {
      if (Math.random() < probability) {
        newRow = (newRow | POSITIONS[i]) >>> 0;
      }
    }
    return newRow;
  }
  
  render() {
    console.log("\x1B[2J"); // clear screen
    this.board.forEach((row) => { console.log(this.rowToString(row, '👾'))});
    console.log(this.rowToString(this.player, '🚀'));
    console.log("SCORE: ", Math.floor(this.steps / 8));
  }
  
  rowToString(row, character) {
    return Array.from(POSITIONS).map((p, i) => {
      return ((p & row) >>> 0 !== 0) ? character : ' ';
    }).join('');
  }
  
  moveRight() {
    if (this.player !== RIGHTMOST_POSITION) {
      this.player = (this.player << 1) >>> 0;
      this.render();
    }
  }
  
  moveLeft() {
    if (this.player !== LEFTMOST_POSITION) {
      this.player = this.player >>> 1;
      this.render();
    }
  }
}

let dodger = new Dodger();
var timer;
timer = setInterval(function() {
  if (dodger.playing) {
    dodger.step();
  } else {
    console.log("game over!");
    process.exit();
  }
}, 500);

process.stdin.on('keypress', function (ch, key) {
  if (key && key.name == 'left') { dodger.moveLeft(); }
  if (key && key.name == 'right') { dodger.moveRight(); }
  if (key && key.ctrl && key.name == 'c') { process.exit(); }
});
 
process.stdin.setRawMode(true);
process.stdin.resume();
