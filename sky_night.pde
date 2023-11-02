// Stars
int numStars = 100; // Number of stars
float[] starX = new float[numStars]; // X positions of the stars
float[] starY = new float[numStars]; // Y positions of the stars
float[] starBrightness = new float[numStars]; // Brightness of the stars

// UFO
float ufoX = 400; // Initial X position of the UFO
float ufoY = 300; // Initial Y position of the UFO
int ufoSize = 80; // Size of the UFO
boolean dragging = false; // Moving UFO

// Bubbles
int numBubbles = 10; // Number of bubbles
float[] bubbleX = new float[numBubbles]; // X positions of the bubbles
float[] bubbleY = new float[numBubbles]; // Y positions of the bubbles
float[] bubbleSize = new float[numBubbles]; // Sizes of the bubbles



void setup() {
  size(800, 600);
  noStroke();
  
  // Initialize star positions and brightness
  for (int i = 0; i < numStars; i++) {
    starX[i] = random(width);
    starY[i] = random(height);
    starBrightness[i] = random(100, 255);
  }
  
  // Initialize bubble positions and sizes
  for (int i = 0; i < numBubbles; i++) {
    bubbleX[i] = ufoX;
    bubbleY[i] = ufoY;
    bubbleSize[i] = random(10, 20);
  }
}

void draw() {
  background(0);
  
  // Draw stars
  for (int i = 0; i < numStars; i++) {
    fill(255, 255, 255, starBrightness[i]);
    ellipse(starX[i], starY[i], 5, 5);
    
    // Randomly change the brightness of the stars
    starBrightness[i] += random(-10, 10);
    starBrightness[i] = constrain(starBrightness[i], 100, 255);
  }
  
  // Draw moon
  fill(255, 250, 205); // Light yellow color for the moon
  ellipse(200, 200, 150, 150);
  fill(0);
  ellipse(230, 200, 150, 150);
  
  // Draw bubbles following UFO
  for (int i = 0; i < numBubbles; i++) {
    fill(173, 216, 230, 150); // Light blue color for the bubbles
    ellipse(bubbleX[i], bubbleY[i], bubbleSize[i], bubbleSize[i]);
    
    // Update bubble positions to follow UFO
    if (i == 0) {
      bubbleX[i] = lerp(bubbleX[i], ufoX, 0.1);
      bubbleY[i] = lerp(bubbleY[i], ufoY, 0.1);
    } else {
      bubbleX[i] = lerp(bubbleX[i], bubbleX[i - 1], 0.1);
      bubbleY[i] = lerp(bubbleY[i], bubbleY[i - 1], 0.1);
    }
  }
  
  // Draw UFO
  fill(160, 160, 160); // Grey color for the UFO
  ellipse(ufoX, ufoY, ufoSize, ufoSize / 2);
  
  // Draw alien
  float alienSize = ufoSize / 2;
  fill(50, 205, 50); // Green color for the alien
  ellipse(ufoX, ufoY - ufoSize / 4, alienSize, alienSize);
  
  // Draw alien's eye
  float eyeSize = alienSize / 2;
  fill(255); // White color for the eye white
  ellipse(ufoX, ufoY - ufoSize / 4, eyeSize, eyeSize);
  
  float pupilSize = eyeSize / 2;
  fill(0); // Black color for the pupil
  ellipse(ufoX, ufoY - ufoSize / 4, pupilSize, pupilSize);
}

void mousePressed() {
  if (dist(mouseX, mouseY, ufoX, ufoY) < ufoSize / 2) {
    dragging = true;
  }
}

void mouseDragged() {
  if (dragging) {
    ufoX = mouseX;
    ufoY = mouseY;
  }
}

void mouseReleased() {
  dragging = false;
}
