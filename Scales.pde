import java.util.ArrayList;


//set vars for grid & scale dimensions
final static int numPixels = 400;
final static int gridDivisions = 200;
final static int maxSize = 4;
final static int sizeIncrement = 8;

//set vars for actuall processing units
int pointDistance = numPixels / gridDivisions; // TODO: rounding?
int realMaxSize = pointDistance * maxSize;
int realSizeIncrement = realMaxSize / sizeIncrement;


//create Arrays

ArrayList<ArrayList<Integer>> emptyGrid = new ArrayList();
ArrayList<ArrayList<Integer>> scales = new ArrayList();
boolean[][] filledPixels = new boolean[numPixels][numPixels];

void generateArrays(){
  //emptyGrid
  for(int i = 0; i < gridDivisions; i++){
    for(int j = 0; j < gridDivisions; j++){
    ArrayList<Integer> gridPoint = new ArrayList();
    gridPoint.add(pointDistance * j);
    gridPoint.add(pointDistance * i);
    emptyGrid.add(gridPoint);
    }
  }
}


void setup(){
  size(400, 400);
  generateArrays();

 
  
  while(emptyGrid.size() > 0){
    //println(emptyGrid.size());
    
    int currentPoint = (int) (Math.random()*emptyGrid.size()); 
  
    int x = emptyGrid.get(currentPoint).get(0);
    int y = emptyGrid.get(currentPoint).get(1);
  
    ArrayList<Integer> nearestCircle = null;
    double smallestDistance = numPixels;
    double currentDistance;
  
    for(int i = 0; i < scales.size(); i++) {
        ArrayList<Integer> scale = scales.get(i);
        currentDistance = Math.sqrt(Math.pow((x - scale.get(0)), 2.0)+ Math.pow((y - scale.get(1)), 2.0)) - scale.get(2);
        if( currentDistance < smallestDistance) {
          smallestDistance = currentDistance;
          nearestCircle = scale;
        }
    }
    
    if(nearestCircle != null && smallestDistance <= realMaxSize) {
      if (smallestDistance > 0) {
        ArrayList<Integer> scale = new ArrayList();
        scale.add(x);
        scale.add(y);
        scale.add((int) smallestDistance);
        scales.add(scale);        
      }
    } else {
        ArrayList<Integer> scale = new ArrayList();
        scale.add(x);
        scale.add(y);
        scale.add(realMaxSize);
        scales.add(scale);
    }
    
    emptyGrid.remove(currentPoint);
  }
}

void draw(){
  background(255);
  color c1 = color(110, 255, 255); // A purple-blue
  color c2 = color(218, 247, 69); // A yellowish-pink
  for(int i = 0; i < scales.size(); i++){
    ArrayList<Integer> scale = scales.get(i);
    float noiseVal = noise(scale.get(0)*.01, scale.get(1)*.01);
    color c = lerpColor(c1, c2, noiseVal);
    
    println(noise(scale.get(0), scale.get(1)));
    fill(c-160);
    ellipse(scale.get(0), scale.get(1), 2 * scale.get(2), 2 * scale.get(2));
  }  
}
