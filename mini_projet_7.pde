int get_max(int [] tabl){
  int maxi = tabl[0];
  for (int i = 1; i < tabl.length; i++){
    if (maxi < tabl[i]){
      maxi = tabl[i];
    }
  }
  return maxi;
}

int [] histo_blue_liste(PImage img){
  int [] return_val = new int [256];
  for (int i = 0; i < img.width; i++){
    for (int j = 0; j < img.height; j++){
      return_val[int(blue(img.get(i, j)))]++;
    }
  }
  return return_val;
}

void histo_blue_img(PImage img, int x, int y, int widthh, int heighth){
  int h, maxi;
  y += heighth;
  stroke(#0000ff);
  int [] his_blue;
  his_blue = histo_blue_liste(img);
  maxi = get_max(his_blue);
  for (int i = 0; i < 256; i++){
    h = y - int(map(his_blue[i], 0, maxi, 0, heighth));
    line(x + int(i  * widthh / 255), y, x + int(i  * widthh / 255), h);
  }
}

int [] histo_bright_liste(PImage img){
  color px;
  int [] return_val = new int [256];
  for (int i = 0; i < img.width; i++){
    for (int j = 0; j < img.height; j++){
      px = img.get(i, j);
      return_val[int( .3 * green(px) +  .6 * red(px) + .1 * blue(px))]++;
    }
  }
  return return_val;
}

void histo_bright_img(PImage img, int x, int y, int widthh, int heighth){
  int h, maxi;
  y += heighth;
  stroke(#777777);
  int [] his_bright;
  his_bright = histo_bright_liste(img);
  maxi = get_max(his_bright);
  for (int i = 0; i < 256; i++){
    h = y - int(map(his_bright[i], 0, maxi, 0, heighth));
    line(x + int(i  * widthh / 255), y, x + int(i  * widthh / 255), h);
  }
}

int [] histo_rouge_liste(PImage img){
  int [] return_val = new int [256];
  for (int i = 0; i < img.width; i++){
    for (int j = 0; j < img.height; j++){
      return_val[int(red(img.get(i, j)))]++;
    }
  }
  return return_val;
}

void histo_rouge_img(PImage img, int x, int y, int widthh, int heighth){
  int h, maxi;
  y += heighth;
  stroke(#ff0000);
  int [] his_rouge;
  his_rouge = histo_rouge_liste(img);
  maxi = get_max(his_rouge);
  for (int i = 0; i < 256; i++){
    h = y - int(map(his_rouge[i], 0, maxi, 0, heighth));
    line(x + int(i  * widthh / 255), y, x + int(i  * widthh / 255), h);
  }
}

int [] histo_vert_liste(PImage img){
  int [] return_val = new int [256];
  for (int i = 0; i < img.width; i++){
    for (int j = 0; j < img.height; j++){
      return_val[int(green(img.get(i, j)))]++;
    }
  }
  return return_val;
}

void histo_vert_img(PImage img, int x, int y, int widthh, int heighth){
  int h, maxi;
  y += heighth;
  stroke(#00ff00);
  int [] his_vert;
  his_vert = histo_vert_liste(img);
  maxi = get_max(his_vert);
  for (int i = 0; i < 256; i++){
    h = y - int(map(his_vert[i], 0, maxi, 0, heighth));
    line(x + int(i  * widthh / 255), y, x + int(i  * widthh / 255), h);
  }
}

PImage contraste(PImage img_or, float coef){
  int x, y;
  float r, g, b;
  color px;
  PImage return_val = createImage(img_or.width, img_or.height, RGB);
  for (x = 0; x < img_or.width; x++){
    for (y = 0; y < img_or.height; y++){
      px = img_or.get(x, y);
      r = int(127 + (int(red(px)) - 127) * coef);
      g = int(127 + (int(green(px)) - 127) * coef);
      b = int(127 + (int(blue(px)) - 127) * coef);
      return_val.set(x, y, color(r, g, b));
    }
  }
  return return_val;
}

void setup(){
  int formatx = int(displayWidth * .4), formaty = int(displayHeight * .4), x_histog = formatx + 20, xhisto = x_histog + 128;
  size(displayWidth, displayHeight);
  background(#000000);
  
  PImage img = loadImage("Odyssey.png");
  image(img, 10, 10, formatx, formaty);
  
  textAlign(CENTER, TOP);
  textSize(40);
  noFill();
  noStroke();
  textSize(30);
  textAlign(CENTER, TOP);
  text("Image origine", xhisto + 250, formaty / 2);
  
  textSize(13);
  text("histogramme de la composante rouge", xhisto, 110);
  histo_rouge_img(img, x_histog, 10, 256, 100);
  
  text("histogramme de la composante verte", xhisto, 240);
  histo_vert_img(img, x_histog, 140, 256, 100);
 
  text("histogramme de la composante bleue", xhisto, 370);
  histo_blue_img(img, x_histog, 270, 256, 100);
  
  text("histogramme luminosité", xhisto, 500);
  histo_bright_img(img, x_histog, 400, 256, 100);
     
  textSize(13);
  text("histogramme de la composante rouge", xhisto, formaty + 110);
  
  
  text("histogramme de la composante verte", xhisto, formaty + 240);
  
 
  text("histogramme de la composante bleue", xhisto, formaty + 370);
  
  
  text("histogramme luminosité", xhisto, formaty + 500);
  
}


void keyPressed(){
  
}


void draw(){
  int formatx = int(displayWidth * .4), formaty = int(displayHeight * .4), x_histog = formatx + 20;
  PImage img = loadImage("Odyssey.png");
  PImage img2 = contraste(img, 1.01);
  image(img2, 10, 40 + formaty, formatx, formaty);
  histo_rouge_img(img2, x_histog, formaty + 10, 256, 100);
  histo_vert_img(img2, x_histog, formaty + 140, 256, 100);
  histo_blue_img(img2, x_histog, formaty + 270, 256, 100);
  histo_bright_img(img2, x_histog, formaty + 400, 256, 100);
}
