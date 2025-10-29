
PShape head;
PShape leg;
PShape leg2;
PShape arm;
PShape arm2;
PShape forearm;
PShape forearm2;
PShape shell;

void setup()
{
  size(800,600,P3D);
  head = loadShape("head.obj");
  leg = loadShape("leg.obj");
  leg2 = loadShape("leg2.obj");
  arm = loadShape("arm.obj");
  arm2 = loadShape("arm2.obj");
  forearm = loadShape("forearm.obj");
  forearm2 = loadShape("forearm2.obj");
  shell = loadShape("shell.obj");
  
  head.disableStyle();
  shell.disableStyle();
}
PVector legPos = new PVector(90,95,0);
PVector headPos = new PVector(0,-130,-25);
PVector armPos = new PVector(65,-15,0);
PVector forearmPos = new PVector(120,-60,-25);

float rot = 0;
boolean rotIr = true;
float pos = -300;
void draw()
{
    lights();
    background(0, 125, 125);
    stroke(0);
    strokeWeight(1.5);
    translate(width/2, height/2);
    scale(0.75);
    rotateX(PI/3);
    rotateZ(PI/1.25);
    pushMatrix();
    
    fill(0,255,0);
    translate(0,-pos,0);
    ObjShape(shell, 0,0,0,0,0,0);
    
    //Pernas
    pushMatrix();
    rotateZ(radians(rot));
    
    translate(legPos.x, legPos.y, legPos.z);
    ObjShape(leg,legPos.x,legPos.y,legPos.z,0,0,0);
    popMatrix();
    
    pushMatrix();
    rotateZ(-radians(rot));

    translate(-legPos.x, legPos.y, legPos.z);
    ObjShape(leg2,legPos.x,legPos.y,legPos.z,0,0,0);
    popMatrix();
    //Pernas-Fim
    
    //Cabeça
    pushMatrix();
    rotateX(radians(rot));
    fill(0,255,255);
    translate(headPos.x, headPos.y, headPos.z  );
    ObjShape(head, headPos.x, headPos.y, headPos.z ,0,0,0);
    popMatrix();
    //Cabeça-Fim
    
    //Antebraço e Braço
    pushMatrix();
       rotateZ(radians(rot));
       translate(forearmPos.x, forearmPos.y, forearmPos.z);
       ObjShape(forearm,forearmPos.x, forearmPos.y, forearmPos.z,0,0,0);
       pushMatrix();
           rotateZ(radians(rot*1.5));
           translate(armPos.x, armPos.y, armPos.z);
           ObjShape(arm, armPos.x, armPos.y, armPos.z,0,0,0);
       popMatrix();
      
    popMatrix();
       
    pushMatrix();
       rotateZ(-radians(rot));
       translate(-forearmPos.x, forearmPos.y, forearmPos.z);
       ObjShape(forearm2,-forearmPos.x, forearmPos.y, forearmPos.z,0,0,0);
       pushMatrix();
           rotateZ(-radians(rot*1.5));
           translate(-armPos.x, armPos.y, armPos.z);
           ObjShape(arm2, -armPos.x, armPos.y, armPos.z,0,0,0);
       popMatrix();
      
    popMatrix();
    //Antebraço e Braço-Fim
  
    
    popMatrix();

    rot += rotIr? -log(5)/4 : log(5)/2;
    if (rot >= 10)
      rotIr = true;
    if (rot < -7)
      rotIr = false;
    println(rot);
    pos+= log(5)/2;
    if (pos>= 300)
      pos = -300;
}

void ObjShape(PShape modelo, float iX, float iY, float iZ , float rotX, float rotY, float rotZ)
{

  translate(iX, iY, 0);

  rotateZ(radians(rotZ));
  rotateX(radians(rotX));
  rotateY(radians(rotY));
  translate(-iX, -iY, 0);

  shape(modelo);
}
