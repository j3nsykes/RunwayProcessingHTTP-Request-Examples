// SENSE AND SENSIBILITY WORKSHOP THREE: GENERATING IMAGES AND VECTOR ARRAY VIA RUNWAY
/* To run this sketch, you will need to have the Runway Desktop application open, and running the AttnGAN model BEFORE
 starting your Processing sketch. */


// LIBRARIES AND GLOBAL VARIABLES -----------------------------
import http.requests.*; // Import the HTTP Requests Library for Processing
import java.util.Base64; // Import the Java Base64 Library
import java.io.FileOutputStream; // Import the Java File Output Stream Library

PImage img; // Variable to hold your image

String inputVector = "[0.61924082021375236,-0.55263987128003611,0.09027194370052453,-0.0095626292766815,-0.05760778414404148,-0.021257743860919283,-0.13282937998246497,0.05760159483856303,0.09440224107098609,-0.019542225628148505,0.03768442615866148,-0.04199848989888128,-0.010089701021404343,-0.10969593320605618,-0.028268463615349914,-0.009799786353701281,-0.06814540244764584,0.0027924661495080244,-0.14183398351208115,-0.03747085955599512,0.13252345952928127,-0.25090991821355735,-0.17231571003189358,-0.022237150138539344,0.1239362159007013,0.025221522024352364,0.08497787461595445,0.026865018938732735,0.0515203262061052,-0.17886799060098663,0.11886811265864594,0.08395466515798863,-0.009143808149260614,-0.20857685300019024,-0.01071661655647553,0.14794161146561438,0.004925637840914918,0.2568193638961326,0.053224132839959824,-0.18815068036121702,0.053733571272191846,0.08308476489572691,-0.07623836808575044,-0.21226337116576496,-0.16363567741048834,0.029007360595983293,0.09605828962150414,0.07209340780779488,0.09390407283913567,0.07848825962469662,-0.12660227302974322,-0.010949704528662414,-0.20422588667802158,0.08311832332835775,0.052934546643651055,0.1093917928721061,-0.012254608571559888,0.0626986445376914,0.29849094946250193,-0.09690035277348423,-0.2586264149695174,0.13862133362407156,-0.11152320305899205,0.0867890353577421,0.02021134226419599,0.04993663239077495,-0.12962516282697445,0.07853560018414853,-0.02181088786097022,0.07822034469575632,0.1530319060541469,0.05740505428366828,0.22583652512519714,-0.0953400820577516,0.26572279287761336,0.022118963903060816,0.14012669160300453,-0.23806514546174007,0.023133517887848322,0.1126826485563794,-0.010267405550984935,0.18860567931775404,0.014851364800377999,-0.04965922250705971,-0.046754176149406544,-0.04938944192656942,0.07838504928742103,0.003233072896957432,0.13105703394646767,-0.16635094190743827,-0.03522398982130727,0.15105350832786363,0.012142388712311745,0.05601896135210335,-0.050046126377351556,0.17897026959436027,0.16852728623170696,0.08548143390194377,0.023195940835844506,0.06574296218212382,-0.010745380166186343,-0.012654113473777984,-0.055823474884005735,-0.017809077495278755,-0.030200659688289583,-0.18079091364090916,-0.023007838080451933,0.13644832960905504,0.02887391867262625,-0.048286825855880344,-0.05886200141043089,0.009531582268137377,0.03930740579801123,-0.036730293924017984,0.12704584363062812,-0.029772578574855886,0.11830965148115188,-0.19827908844439035,-0.10385968485431539,0.07585152934397686,-0.13097182077723526,0.010124371526290369,-0.21050954812236605,0.012610750166108246,-0.12447777185219969,0.08313078611918372,-0.13005151549118402,-0.24985936352576854,-0.13657101087281037,0.07272723155641905,0.11410120400330495,0.030206396584217404,0.11647230104330411,0.05400511998068739,0.2242006602046324,0.12905652154531805,-0.169526825987922,0.0804574716106436,0.16915827719256157,0.1023774667418608,-0.09351974821389092,0.11973557356932724,-0.03987443847302287,-0.08964569231710914,-0.16164050309265504,0.11908694123787841,-0.0028354499408430158,0.12827552378401424,-0.03860165162584958,-0.01240404513254311,0.12716756504259744,0.08435429429255287,0.12133656348220456,-0.03297988055331831,-0.04589985075721893,-0.008718654107584867,-0.04362793365895444,0.05184487541321835,-0.2098915872729415,-0.04219824209470481,-0.24262546445922656,0.01677188555775939,0.02247581799671302,0.020440698376116992,-0.050696308071227346,-0.015668934542065832,-0.00742792158192053,-0.03808500491878393,-0.04885918423778272,0.09074340754308124,-0.05964666963136634,0.09959614529632585,-0.08954196018610647,-0.07607851826960901,-0.018311472447925053,-0.1497021308594467,-0.12268826657938775,-0.0754515767622006,-0.00017966649849149308,0.00022461593527737383,0.15945603228883304,0.1645929806554856,-0.022601878725779394,-0.1050600372643902,0.38269333699622876,0.04452338237574536,0.0859835501667755,-0.041382963764318145,-0.08430609760853877,0.06940041090082463,0.08227630142261179,-0.03055508188310349,0.19029535510108608,-0.14282283007231425,-0.0835995947410341,0.03257574759384924,0.14168709740774735,0.0360160390906915,-0.019124130649403825,0.04792795579050969,-0.0006170623815040925,0.09906700785573544,0.040065937872706646,0.2831711767125703,-0.1251541277961233,0.28681249393293096,-0.07086419902410841,-0.2001897648964134,0.12073553796012908,-0.07098642001212062,0.2236861923664899,0.0720138212185383,0.15689026372102563,-0.07038474977761305,0.23447739769439718,0.03741416742373166,0.030674656274074924,0.09407063991864174,-0.11120480187875655,-0.11516399407638926,0.08411860692758863,0.10208523739893463,-0.2458354661662576,0.01008699942281878,-0.10701250487909246,0.03545946657773445,0.023954183643335784,-0.0022198020303690856,-0.046085292789399775,-0.1062401838937777,0.0451831328752498,-0.02450720018841175,-0.21288869438530708,0.008580996011216334,-0.02441275244335902,0.14196023415073106,-0.16459345355947835,-0.12024163194981093,0.01604281358557385,0.052978122948707976,0.11844183781849867,-0.13862638010495215,-0.13712806455042933,-0.10790136942147097,0.038721389986812314,-0.022944935375762095,0.027362316317655344,-0.0988652536459245,-0.03565834902956747,0.10623844958147435,-0.0057562079405804045,-0.12980362115641536,0.033029391375292254,0.08853259153548707,0.025409070316351902,0.10424325547881796,0.05644685070287647,-0.25942453496002427,-0.07988122267750025,0.052661627431030075,0.04214511949012335,-0.056227117960083575,-0.009234709556502319,-0.26292102572954074,0.13262468820375103,0.2398177681108562,0.07910536393928383,0.038138641709930705,0.20925626369274536,0.10769151951274147,0.030396427570942342,-0.05205588709299779,0.0018919409132889947,-0.1931652862975131,0.13691755303923994,-0.017817697285889736,0.066612128201244,0.07004665234779331,0.11876258501515187,0.09617465036148154,0.03684179962384117,-0.0119711224723003,0.12712487495793037,-0.02773413176570368,-0.04024775817287458,-0.11831302887966848,-0.015043471132254141,0.013456343183776608,-0.07533814898683795,-0.07426567221820032,-0.07267590010475723,-0.3302463308077853,0.1537099532748755,0.03278609657915175,-0.04618382923738987,0.016875139042265702,-0.18237366574537872,0.006191147798228028,-0.24842961272877598,0.03880641895915141,-0.11141591721672443,0.12345141953770572,0.19125726792014047,0.08361898997970797,-0.1249864856338332,-0.05644788919926978,0.1496310923028369,-0.060788035313586,-0.08299352706201626,0.097050451731835,-0.13585432818618287,0.0730909738800865,-0.11911138969708099,0.15505512190491344,0.2979086233863656,-0.025758586824488606,0.21168044429560398,-0.031433621761811505,-0.07565055101414225,0.021491864216902086,-0.3332191521762139,-0.04928238459638094,-0.003819756296089924,-0.09636932210750457,0.23302142287569022,-0.0407537285948847,-0.10596257145204091,0.019065451581596844,0.11544634675586846,0.21347474612786646,-0.040758856066910626,0.07276072725073289,0.12373643960071334,-0.04998928165506524,-0.05457187392476457,-0.010258981055712468,0.13730706604630047,0.22207257743924724,-0.12451335361836516,0.15601326097481774,0.0689551259191432,-0.11520994349324022,0.1828663568616183,-0.2559868772384115,0.09786829682577436,0.2430106041226027,-0.10015620847722422,-0.09358069334991256,0.14325209857974808,0.10090463522119142,-0.10414979586011512,0.09720285009954713,-0.15685749818563957,-0.043304603698287245,0.08414256268884397,-0.00739373199915778,0.08389687007063254,0.09324812868851377,-0.12792958700849164,0.16185541804250442,0.19013427669345861,-0.06590765222950645,0.09111732857452166,0.04155410907094722,-0.01585358913238555,0.045389186754683716,-0.2731931472402805,0.06659892393307003,0.026256366437608456,-0.011674231893093419,0.0007584453193974772,-0.02788306077418415,0.08802147730788389,0.14389195832273252,-0.030824395235847415,-0.06879991807691681,-0.04839998258066497,0.2508350017237906,-0.054081948063594856,0.08475045721186934,0.2116598631969628,0.140511798985786,-0.059939380268846494,0.03891003400674105,-0.3733272036196823,-0.03535977794833446,-0.10496445942494194,-0.3626679790932566,0.07987614658735945,-0.03062804298552115,0.09340768832774388,0.042907339193358485,0.12790696101898633,0.017119875306406258,0.0663362499092463,0.11480108733319166,-0.1252408349834173,-0.0797314970264968,0.047387668116729335,-0.0519178180136568,0.2024955751011288,-0.06371413040969229,-0.0974347170150357,-0.1072998117692436,0.03160543216752713,0.2061631217851197,-0.17125782152820967,-0.06759594275782663,0.013505706061365079,-0.06877802521091274,0.03344506796167465,0.09544609560618995,0.10655513984295804,0.1973282362351476,-0.14183818932778977,-0.12674212606220114,-0.051398286452470354,-0.07160540829846425,0.0337992685209767,0.07014856654130938,-0.06490807482369222,-0.05572121024012558,-0.1101809029810139,-0.027818430547869186,0.016656960177730253,0.09828352767035713,0.23694430839398298,-0.11464031538598453,0.08390102786050521,0.0384803202215163,-0.07259279778269376,-0.07426909197672163,-0.05486556958921246,-0.10546328894395578,0.12963329842340385,0.032019859583256656,-0.01905957457948764,-0.07678929040750096,0.0640398621118557,0.131290006409138,0.05906127422259262,-0.1151324799898416,-0.07196920982250393,-0.060157285832899934,0.03993926065526804,-0.2864346377565051,0.09301197541943144,-0.05379460828581395,-0.10281592076972737,-0.040094589818666954,0.2483431999282206,-0.14362744055168206,0.11120586641175181,0.1418981036631886,0.02456743605094946,-0.09975041017921496,-0.020837935791570318,0.1107270737234003,0.1956995530192,0.027739330533597333,-0.09305697589582154,0.03777088756197473,-0.10870221810012165,0.08322746352053081,0.11571430793599374,-0.11341406679567101,0.011245532542309596,0.04807882928671295,0.007933026161155984,-0.030873451387388846,-0.007249391808847419,0.10154641745004836,0.11704651630413232,0.1975276492152748,-0.22603989415061865,0.08006420123872982,0.015326980965072984,0.16042293733582863,0.04056040562700773,-0.0829810053825902,0.07130768894971282,0.18397320021027339,0.08503319386064132,-0.05482289070420794,0.03254075448404244,0.038723905500280334,0.1563420963919941,0.04783367368944183,0.31605967870687984,-0.1376580531673488,-0.04986455778896622,0.009712092779135257,0.08712555416560834,-0.02607619353864292,0.005654351618703916,0.08174085600779549,0.035689979315009834,-0.08530065176766073,0.13148198669838596,-0.10545901697395568,-0.01865415290271301,0.08099832090090302,0.06611602403017802,0.11863422402020624,0.05545635593813231,0.02109831160147226,-0.05057315317456637,-0.011033968896791533,0.017073516988507155,-0.25028151393697035,-0.12155495684630128,0.02012827080247513]"; // Variable to hold your current caption
float truncation = 0.8;
PFont font; // Your font

//declare number of vectors in StyleGAN2 model (512 floats)
int vectors = 512;
String _zString ="";
//declare arrays for receiving vectors values
float[] z = new float[vectors];
float[] arrayLerp = new float[vectors];
String[] zString = new String[vectors];
// declare lerp speed
float lerpSpeed = 0.005;

// SETUP ------------------------------------------------------
void setup() {

  size(512, 560);
  background(0);

  font = loadFont("SourceCodePro-Medium-16.vlw"); // Load the font from teh sketch's data folder
  textFont(font); // Set the text font
  textAlign(CENTER); // Set the text alignment
}


// DRAW -------------------------------------------------------
void draw() {

  background(0);
  // loop to generated a random float between -1 and 1 and input into vector
  for (int i = 0; i < (vectors); i++) {
    // generates random floats between -1 and 1
    z[i] = random(-1, 1);
 // lerps between last random float value to the next
   arrayLerp[i] = lerp(arrayLerp[i], z[i], lerpSpeed);
   String[] _z = str(arrayLerp);
   zString = _z;
  }

  // joins zString array into one string
  _zString = join(zString, ", ");
  //println(_zString);


  if (img!=null) {//is there an image returned?
    image(img, 0, 0, 512, 512); // Draw your image to screen
  }
  fill(255);
  text(inputVector, width/2, height - 24); // Draw your caption at the bottom of the screen
}


// KEY PRESSED ------------------------------------------------
/* Although we're using keyPressed in this example, you could tie sending the prompt in Runway to another event in Processing,
 or connect to Arduino and use a sensor-based trigger. */
void keyPressed() {

  if (key == 'g') { // If the key pressed is 'g'
    generateImage(); // Call the function to generate your image
  }
}


// GENERATE IMAGE ---------------------------------------------
/* IMPORTANT: DO NOT call this function from DRAW unless you have it on a timer. If you call this function
 60 times a second you could very quickly a) hit a rate limit and b) use up all your cloud credits very quickly! */
void generateImage() {

  // Create a POST request to send to Runway
  PostRequest post = new PostRequest("http://localhost:8000/query"); // Replace this with the POST address in your Runway window (the port number may be differnet on your machine)
  post.addHeader("Accept", "application/json"); // Tell Runway what kind of data to expect, i.e. JSON
  post.addHeader("Content-Type", "application/json");
  // Add your prompt
  //"{\"z\":"+test+",\"truncation\":"+0.5+"}"
  post.addData("{\"z\":["+_zString+"],\"truncation\":"+truncation+"}"); // Add your prompt
  post.send(); // Send your request to Runway

  /* Important: What we're doing here is essentially writing a JSON Object as a String. The formatting needs to be precise, or
   Runway will return an error message. This works ok for models like attnGAN that only have one input parameter, but for
   more complicated models, you should always create a JSON Object, then convert it to a String. */

  JSONObject response = parseJSONObject(post.getContent()); // Get the entire response from Runway as a JSON Object
  //println(response); // Uncomment this line to print the whole response to the console

  String base64 = response.getString("image"); // Extract the Base64 String from the response
  decodeImage(base64); // Pass the string to the decodeImage function
}


// DECODE IMAGE -----------------------------------------------
void decodeImage(String base64) {

  String [] splits = splitTokens(base64, ", "); // Get rid the info at the start of the returned string - we don't need this
  byte [] decodedBytes = Base64.getDecoder().decode(splits[1]); // Decode the String into a Byte Array

  String fileName = "genImg" + str(frameCount) + ".jpg"; // Create a new String to hold the file name for your generated image
  /* Adding the frameCount in here is to help prevent you accidentally over-writing your images, however, this is not 100% full-proof,
   as the frameCount resets every time you re-start the sketch. */

  // Write the image to a file - make sure you replace the file path here with the path to the sketch folder on your own computer.
  try(OutputStream stream = new FileOutputStream("/Users/jensykes/Documents/" + fileName)) {
    stream.write(decodedBytes);
  }

  catch (Exception e) { // If something goes wrong, print an error message.
    println("Unable to write file.");
  }

  img = loadImage("/Users/jensykes/Documents/" + fileName); // Load your generated image into the img variable.
}
