String sTime = "";
String hours = "", minutes = "", seconds = "", msg = "", weatherCode = "5202869";
PShape cloud, celciusIcon, weatherIcon;
//weather url: http://api.openweathermap.org/data/2.5/weather?id=5202869
JSONObject weatherJson;
int minutesInt, hoursInt, secondsInt, miliInt, test = 0;
void setup() {
  TestRunnable test = new TestRunnable();
  test.start();
  background(0);
  size(displayWidth, displayHeight);
  textAlign(CENTER);
  cloud = loadShape("Cloud.svg");
  cloud.disableStyle();
  cloud.scale(0.1);
  weatherIcon = loadShape("SVG/25.svg");
  weatherIcon.disableStyle();
  weatherIcon.scale(0.5);
  celciusIcon = loadShape("SVG/46.svg");
  celciusIcon.disableStyle();
  celciusIcon.scale(0.2);
  weatherJson = loadJSONObject("http://api.openweathermap.org/data/2.5/weather?id="+weatherCode);
  (weatherJson.getJSONArray("weather").getJSONObject(0).getString("icon")).equals("04d");
}

void draw() {
  //draws the clock
  displayClock();
  
  //draws the weather
  displayWeather();
  
  //some other silly stuff
  displayMsg();
}

void displayMsg(){
    miliInt = millis();
  if(miliInt%500000 < 5000 && miliInt%500000 > 0){
    msg = "hey handsome";
  } else if(miliInt%500000 < 10000 && miliInt%500000 > 5000){
    msg = "lookin' good";
  } else if(miliInt%50000 < 15000 && miliInt%500000 > 10000){
    msg = "it's lookin' like a good day";
  } else if(miliInt%50000 < 20000 && miliInt%500000 > 15000){
    msg = "you are beautiful!";
  } else if(miliInt%50000 < 25000 && miliInt%500000 > 20000){
    msg = "your future is lookin' bright";
  } else if(miliInt%50000 < 30000 && miliInt%500000 > 25000){
    msg = "lookin' spiffy!";
  } else if(miliInt%50000 < 35000 && miliInt%500000 > 30000){
    msg = "there is a cake in your future";
  }
  textAlign(CENTER);
  text(msg, displayWidth*0.5, 500);
  
}

void displayClock(){
  hoursInt = hour();
  minutesInt = minute();
  secondsInt = second();
  noStroke();
  smooth();
  fill(0);
  ellipse(displayWidth/2, displayHeight/2, displayWidth, displayHeight);
  ellipse(300, 300, 1000, 1000);
  fill(255);
  arc(300, 300, 320, 320, -PI/2, PI*(hoursInt%12 + float(minutesInt)/60)/6-PI/2, PIE);
  fill(0);
  ellipse(300, 300, 250, 250);
  fill(255);
  arc(300, 300, 240, 240, -PI/2, PI*(minutesInt+float(secondsInt)/60)/30-PI/2, PIE);
  fill(0);
  ellipse(300, 300, 200, 200);
  fill(255);
  arc(300, 300, 190, 190, -PI/2, PI*(secondsInt)/30-PI/2, PIE);
  fill(0);
  ellipse(300, 300, 180, 180);
  textSize(50);
  fill(255);
  if (hoursInt < 10) {
    hours = "0";
    hours = hours + hoursInt;
  } else {
    hours = str(hoursInt);
  }
  if (minutesInt < 10) {
    minutes = "0";
    minutes = minutes + minutesInt;
  } else {
    minutes = str(minutesInt);
  }
  text(hours + ":" + minutes, 300, 320);
}

void displayWeather(){
    minutesInt = minute();
  if (minutesInt == 5) {
    weatherJson = loadJSONObject("http://api.openweathermap.org/data/2.5/weather?id="+weatherCode);
    if ((weatherJson.getJSONArray("weather").getJSONObject(0).getString("icon")).equals("04d")) {
      weatherIcon = loadShape("SVG/25.svg");
      weatherIcon.disableStyle();
      weatherIcon.scale(0.5);
    }
  }
  textAlign(LEFT);
  shape(celciusIcon, displayWidth*0.8+50, 321);
  textAlign(RIGHT);
  shape(weatherIcon, displayWidth*0.8-40, 190);
  text(weatherJson.getJSONObject("main").getInt("temp") - 273, displayWidth*0.8+65, 390);
}


public class TestRunnable  implements Runnable {
  private Thread t;
  private String threadName;
  
  TestRunnable(){
    println("Creating thread");
  }
  
  public void run() {
    try {
      for(int i = 0; i < 50; i++){
        println("RUNNING " + i);
        Thread.sleep(1000);
      }
    } catch (InterruptedException e) {
      println("Thread has failed... ");
    }
  }
  
  public void start(){
    if (t == null) {
      t = new Thread (this);
      t.start();
    }
    println("Starting thread");
  }
  
  //public static void main(String args[]) {
  //  (new Thread(new TestRunnable())).start();
  //}
}

/*
public class ThreadTest extends Thread {
  
  public void run() {
    println("RUNNING");
  }
  
  public static void main(String args[]) {
    (new ThreadTest()).start();
  }
}
*/

