int sell = 100; //細胞数
int [] cell = new int[sell];//細胞が生きているかどうかのフラグ 0:死 1:生
int Rsize = 6;//四角形のサイズ 
int right=0, left=0;//セルの右左の配列の添字を入れる変数
int size = 0;

void setup() {
 
  size(500, 1000);
  smooth();
  background(255);
 
  for (int i=0; i<sell; i++) {//細胞のフラグを初期化する
    //randomの帰り値はfloatなのでキャスト 0 - 2 の乱数を発生させ　intにキャストすると 0 か　1 という値が入るので初期化できる
    cell[i] = int(random(0, 2));
  }
}
 
void draw() {
  drawCells(cell,size);//細胞を描画する
 
  for (int i=0; i<sell; i++) {//ここから配列の処理
 
    //配列の添字関係の処理
    //変数 leftは現在のセルの左の配列 つまり i - 1　変数rightは現在のセルの右の配列 つまり i + 1でアクセスできる
    if (i == 0) {//配列が左端の場合,最後の配列とを参照することで配列が円状になっているようにする
      left = sell - 1;
      right = i + 1;
    }
 
    else if (i == 99) {//配列が右端まで来た場合、最初の配列要素を参照する elseをつけないとダメ
      left = i - 1;
      right = 0;
    }
 
    else {//それ以外の場合 上でelseを付けないと i = 0のとき　0 - 1 で　-1の添字ができてしまう
      left = i - 1;
      right = i + 1;
      println("配列添え字"+"["+left+"]");
    }
    //配列の添字処理修了
 
    //現在のセルが死んでいる場合の処理
    if (cell[i] == 0) {
 
      deadecell(i);
    }//現在のセルが死んでいる場合の処理修了
 
    if (cell[i] == 1) {//現在のセルが生きている場合の処理　条件は玲のごとくもっとスマートに書けると思われ
 
      alivecell(i);
    }
 
  }
  size = size+5;//細胞の描画開始位置を 1段下へする
}
 
void drawCells(int[] cells, int size) {//セルを生死フラグを元に描画する関数 引数は生死フラグが入った配列 sizeは細胞を描画するy軸を決める
 
  for (int i=0; i<sell; i++) {//細胞の生死フラグを元に四角形を描画する
    fill(0);//細胞の色　黒
 
    if (cells[i] == 0) {//死んでいるなら白くする
 
      fill(255);
    }
    
    //細胞を描画する
    rect(i*2, size, Rsize, Rsize);
    
  }
}

void deadecell(int i) {//セルが死んでいる時の判定を行う関数 iはforループ時の変数
 
  if (cell[left] == 1 && cell[right] == 1) {//両隣とも生きている場合 過密　なのでセルは死んだまま
    cell[i] = 0;
  }
  else if (cell[left] == 1 && cell[right] == 0 || cell[left] == 0 && cell[right] == 1) {//右左どちらかが生きている場合は　誕生する
    cell[i] = 1;
  }
  else if (cell[left] == 0 && cell[right] == 0) {//両隣とも死んでいる場合 過疎　なので　セルは死んだ
    cell[i] = 0;
  }
}
void alivecell(int i) {//セルが生きている場合の判定を行う関数 iはforループ時の変数
  if (cell[left] == 1 && cell[right] == 1) {//両隣のセルが生きていると過密なので　セルは死ぬ
    cell[i] = 0;
  }
  else if (cell[left] == 1 && cell[right] == 0 ) {//左のセルが生きている場合　セルは死ぬ
    cell[i] = 1;
  }
  else if (cell[right] == 1 && cell[left] == 0) {//右のセルが生きている場合　セルは生き続ける
    cell[i] = 1;
  }
  else if (cell[left] == 0 && cell[right] == 0) {//両隣のセルが死んでいる場合でも　セルは生き続ける
    cell[i] = 0;
  }
}//修了