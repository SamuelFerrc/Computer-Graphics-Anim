PShape braco1;
PShape braco2;
PShape cabeca;
PShape corpo;
PShape nariz;
PShape pes1;
PShape pes2;

void setup() {
  size(800, 600, P3D);
  braco1 = loadShape("braco1.obj");
  braco2 = loadShape("braco2.obj");
  cabeca = loadShape("cabeca.obj");
  corpo = loadShape("corpo.obj");
  nariz = loadShape("pingu.obj");
  pes1 = loadShape("pes1.obj");
  pes2 = loadShape("pes2.obj");

  tempoInicial = millis();

  braco1.disableStyle();
  braco2.disableStyle();
  cabeca.disableStyle();
  corpo.disableStyle();
  nariz.disableStyle();
  pes1.disableStyle();
  pes2.disableStyle();
}
int estado = 0;

boolean asaVoltar = false;
boolean cabecaVoltar = false;
boolean pesVoltar = false;
float x = 15;
float rotCabeca = 0;
float rotPes = 0;

int tempoInicial = 0;
void draw() {
  background(20);
  lights();
  translate(width/2-100, height/2+50, 0);
  rotateX(PI);
  rotateY(PI);
  scale(15);
  background(255, 255, 255);
  fill(255, 125, 0);
  pinguim();
  translate(-15, 0);
  fill(255, 0, 125);
  pinguim();
}
void pinguim()
{
  // Corpo
  pushMatrix();
  shape(corpo);

  // Braços
  pushMatrix();

  ObjShape(braco1, 2, 4.5, 8, x, -rotPes, 0 );
  popMatrix();

  pushMatrix();
  ObjShape(braco1, -2, 4.5, 8, -x, rotPes, 0);

  popMatrix();

  // Pés
  pushMatrix();
  translate(2, -0.5, 0);
    ObjShape(pes1, 0,0, 2,0,rotPes,0);

  shape(pes1);

  popMatrix();

  pushMatrix();
  translate(-2, -0.5, 0);
  ObjShape(pes2, 0,0, 2,0,-rotPes,0);
  popMatrix();

  // Cabeça
  pushMatrix();

  ObjShape(cabeca, 0, 14, -2, 0, rotCabeca, rotPes);

  // Nariz
  pushMatrix();
  translate(0, 0, -1);
  ObjShape(nariz, 0, -14, 0, 0, 0, 0);
  popMatrix();

  popMatrix();
  popMatrix();

  if (estado == 0) {
    x += asaVoltar? -log(x)/1.5 : log(x)*2;
    rotPes = 0;
    rotCabeca = 0;
    if (x >= 80)
      asaVoltar = true;
    if (x < 5)
      asaVoltar = false;
  } else if (estado == 1)
  {
    x = 15;
    rotPes = 0;
    rotCabeca += cabecaVoltar? -log(x)/2 : log(x)/2;
    if (rotCabeca >= 15)
      cabecaVoltar = true;
    if (rotCabeca < -15)
      cabecaVoltar = false;
  } else if (estado == 2)
  {
    x = 15;
    rotCabeca = 0;
    rotPes += pesVoltar? -log(x)/2 : log(x)/2;
    if (rotPes >= 15)
      pesVoltar = true;
    if (rotPes < -15)
      pesVoltar = false;
  }

  println(millis() - tempoInicial, millis(), tempoInicial);
  if (millis() - tempoInicial >= 5000) {
    println("oi");
    estado++;
    tempoInicial = millis();
  }
  if (estado > 2)
  {
    estado = 0;
  }
}

void ObjShape(PShape modelo, float iX, float iY, float altura, float rotZ, float rotX, float rotY)
{

  translate(iX, iY);
  translate(0, altura, 0);

  rotateZ(radians(rotZ));
  rotateX(radians(rotX));
  rotateY(radians(rotY));
  translate(0, -altura, 0);

  shape(modelo);
}
