// Variables globales
PVector ace = new PVector(0, 0.05);
int cantidadIndividuos = 300;
int pixelesGrilla = 1024;
float minimaVelocidad = -2;
float maximaVelocidad = 2;

// Lista de individuos 
Individuo[] individuos = new Individuo[cantidadIndividuos];


// Funcion que prepara el terreno
// para la simulacion
void setup() {
  
  // Se crea la grilla de 1024 x 1024
  size(1024, 1024);
  
  //Llamamos al metodo generar personas
  generarPersonas();
}

// Metodo que instancia individuos
// Asignandoles vectores de posicion, velocidad y aceleracion
void generarPersonas() {
    
    // Loop por cantidad de inviduos definidos
    for(int i = 0; i < cantidadIndividuos; i ++) {
      
     // Se genera una posicion aleatoria para el individuo
     float posX = random(0, pixelesGrilla - 1);
     float posY = random(0, pixelesGrilla - 1);
     
     // Se genera una velocidad aleatoria para el individuo
     float velX = random(minimaVelocidad, maximaVelocidad);
     float velY = random(minimaVelocidad, maximaVelocidad);
     
     // Se generan los vectores
     PVector pos = new PVector(posX, posY);
     PVector vel = new PVector(velX, velY);
    
    // Se instancia el individuo con los valores
     individuos[i] = new Individuo(pos, vel, ace);
    
  }
}

// Metodo que dibuja en la grilla
void draw() {
  
  background(0);
  
  // Se muestra cada inviduos en el tablero
  // y se cambia su posicion
  for(Individuo individuo : individuos) {
    individuo.display();
    individuo.update();
  }

}

// Clase que modela a un individuo
class Individuo {
  
  // Atributos
  PVector posicion;
  PVector velocidad;
  PVector aceleracion;
  boolean infectado;
  
  // Constructor
  Individuo(PVector pos, PVector vel, PVector ace) {
    posicion = pos;
    velocidad = vel;
    aceleracion = ace;
    
    estaInfectado(); 
  }
  
  // Muestra al individuo
  // Como un circulo y se rellena
  // Verde si no esta infectado y 
  // Rojo si esta infectado
  void display() {
      strokeWeight(1);
      if(infectado) {
         fill(255, 0, 0);   
      }
      else {
        fill(0, 150, 0);
      }
      circle(posicion.x, posicion.y, 20);
}
  
  // Funcion que actualiza
  // las posiciones de los invidivuos
  // Segundo dos tipos de movimiento
  void update() {
    
    // Movimiento Random Walk Gaussian
    movimientoRandomGaussian();
    
    // Movimiento alternativa (descomentar para usar)
    // Se tiene que comentar gaussian para usar tambien
    
    //alternativaMovimiento();
  }
  
  // Funcion que determina
  // Si un individuo esta infectado
  // Con un 10% probabilidad
  void estaInfectado() {
    
    float probabilidadInfectado = 0.1;
    float r = random(0, 1);
    infectado = false;
    if (r <= probabilidadInfectado) {
      infectado = true;
    }
  
  }
  
  // Funcion que modela el random walk gaussian
  void movimientoRandomGaussian() {
    
    posicion.x = posicion.x + (randomGaussian() * 1.5);
    limitesEnX();

    
    posicion.y = posicion.y + (randomGaussian() * 1.5);
    limitesEnY();
    
  }
  
  // Funcion alternativa al movimiento gaussian
  void alternativaMovimiento() {
    
    float numeroAleatorio = random(0, PI);
    float s = random(1, 3);
    
    posicion.x = posicion.x + (s * cos(numeroAleatorio));
    limitesEnX();
    
    posicion.y = posicion.y + (s * cos(numeroAleatorio));
    limitesEnY();
  
  }
  
  // Funcion que determina si el individuo
  // Ha salido de la grilla en los limites de X
  void limitesEnX() {
    
    if(posicion.x < 0) {
      posicion.x = pixelesGrilla - 1;
    }
    
    if(posicion.x > pixelesGrilla - 1) {
      posicion.x = 0;
    }
  
  }
  
  // Funcion que determina si el individuo
  // Ha salido de la grilla en los limites de Y
  void limitesEnY() {
    
    if(posicion.y < 0) {
      posicion.y = pixelesGrilla - 1;
    }
    
    if(posicion.y > pixelesGrilla - 1) {
      posicion.y = 0;
    }
  
  }

}
