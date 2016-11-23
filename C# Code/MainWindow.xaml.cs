using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;

using Microsoft.Research.Kinect.Nui;
using Microsoft.Research.Kinect.Audio;

using Coding4Fun.Kinect.Wpf;

// Captures the Depth Maps and tracks and calculate the skeletal joint angles 
namespace WpfApplication1
{
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        public MainWindow() {
            InitializeComponent();
        }

        private void Window_Closed(object sender, EventArgs e) {
            nui.Uninitialize();
        }

        Runtime nui = new Runtime();
        Camera cam;
        Boolean capture = false;
        String savePath = "grab";
        int fileNumber = 0;
        int skipFrame = 0;
        Int32 saveCounter = 0;
        Int32 saveCounter1 = 0;
        int h = 0;

        float headx,heady,headz;       
        float spinex,spiney,spinez;        
        float handleftx,handlefty,handleftz;       
        float handrightx,handrighty,handrightz;
        float shouldercx, shouldercy, shouldercz;
        float shoulderleftx, shoulderlefty, shoulderleftz;
        float shoulderrightx, shoulderrighty, shoulderrightz;
        float elbowleftx, elbowlefty, elbowleftz;
        float elbowrightx, elbowrighty, elbowrightz;
        float wristleftx, wristlefty, wristleftz;
        float wristrightx, wristrighty, wristrightz;
        float hipcenterx, hipcentery, hipcenterz;
        float hipleftx, hiplefty, hipleftz;
        float hiprightx, hiprighty, hiprightz;
        float kneeleftx, kneelefty, kneeleftz;
        float kneerightx, kneerighty, kneerightz;
        
        float headx2, heady2, headz2;
        float spinex2, spiney2, spinez2;
        float handleftx2, handlefty2, handleftz2;
        float handrightx2, handrighty2, handrightz2;
        float shouldercx2, shouldercy2, shouldercz2;
        float shoulderleftx2, shoulderlefty2, shoulderleftz2;
        float shoulderrightx2, shoulderrighty2, shoulderrightz2;
        float elbowleftx2, elbowlefty2, elbowleftz2;
        float elbowrightx2, elbowrighty2, elbowrightz2;
        float wristleftx2, wristlefty2, wristleftz2;
        float wristrightx2, wristrighty2, wristrightz2;
        float hipcenterx2, hipcentery2, hipcenterz2;
        float hipleftx2, hiplefty2, hipleftz2;
        float hiprightx2, hiprighty2, hiprightz2;
        float kneeleftx2, kneelefty2, kneeleftz2;
        float kneerightx2, kneerighty2, kneerightz2;

        float a;
        float ang1,ang2,ang3,ang4,ang5;
        float ang21, ang22, ang23, ang24, ang25;

        
        private void Window_Loaded(object sender, RoutedEventArgs e) {
            nui.Initialize(RuntimeOptions.UseDepthAndPlayerIndex | RuntimeOptions.UseSkeletalTracking); 
            nui.DepthFrameReady += new EventHandler<ImageFrameReadyEventArgs>(nui_DepthFrameReady);
            nui.DepthStream.Open(ImageStreamType.Depth, 2, ImageResolution.Resolution320x240,
                ImageType.DepthAndPlayerIndex);

            nui.SkeletonFrameReady += new EventHandler<SkeletonFrameReadyEventArgs>(nui_SkeletonFrameReady);
            
            this.cam = nui.NuiCamera;
            this.cam.ElevationAngle = 0;     
        }

        void nui_DepthFrameReady(object sender, ImageFrameReadyEventArgs e) {
            byte[] ColoredBytes = GenerateColoredBytes(e.ImageFrame);

            PlanarImage image = e.ImageFrame.Image;
            BitmapSource bmpSrc = BitmapSource.Create(image.Width, image.Height, 96,96, PixelFormats.Bgr32, null, ColoredBytes,
                image.Width * PixelFormats.Bgr32.BitsPerPixel / 8);
            image1.Source = bmpSrc;
            if (capture && saveCounter%(skipFrame+1) == 0) {
                String fileName = String.Format("{0:d5}.jpeg", fileNumber);
                try {
                    bmpSrc.Save(savePath + "\\" + fileName, ImageFormat.Jpeg);
                    fileNumber++;                 
                } catch (Exception) {
                    try {
                        System.IO.Directory.CreateDirectory(savePath);
                    }
                    catch (Exception) {
                        MessageBox.Show("Problem with saving image");
                        this.Close();
                    }
                }
            }
            saveCounter++;
        }

        // Calculates the skeletal joint angles
        public void nui_SkeletonFrameReady(object sender, SkeletonFrameReadyEventArgs e) {
            SkeletonFrame skeletonsTrack = e.SkeletonFrame;

            SkeletonData skeleton = (from s in skeletonsTrack.Skeletons
                                     where s.TrackingState == SkeletonTrackingState.Tracked   
                                     select s).FirstOrDefault();
            
            headx = skeleton.Joints[JointID.Head].Position.X;
            heady = skeleton.Joints[JointID.Head].Position.Y;
            headz = skeleton.Joints[JointID.Head].Position.Z;

            spinex = skeleton.Joints[JointID.Spine].Position.X;
            spiney = skeleton.Joints[JointID.Spine].Position.Y;
            spinez = skeleton.Joints[JointID.Spine].Position.Z;

            handleftx = skeleton.Joints[JointID.HandLeft].Position.X;
            handlefty = skeleton.Joints[JointID.HandLeft].Position.Y;
            handleftz = skeleton.Joints[JointID.HandLeft].Position.Z;

            handrightx = skeleton.Joints[JointID.HandRight].Position.X;
            handrighty = skeleton.Joints[JointID.HandRight].Position.Y;
            handrightz = skeleton.Joints[JointID.HandRight].Position.Z;

            shouldercx = skeleton.Joints[JointID.ShoulderCenter].Position.X;
            shouldercy = skeleton.Joints[JointID.ShoulderCenter].Position.Y;
            shouldercz = skeleton.Joints[JointID.ShoulderCenter].Position.Z;

            shoulderleftx = skeleton.Joints[JointID.ShoulderLeft].Position.X;
            shoulderlefty = skeleton.Joints[JointID.ShoulderLeft].Position.Y;
            shoulderleftz = skeleton.Joints[JointID.ShoulderLeft].Position.Z;

            shoulderrightx = skeleton.Joints[JointID.ShoulderRight].Position.X;
            shoulderrighty = skeleton.Joints[JointID.ShoulderRight].Position.Y;
            shoulderrightz = skeleton.Joints[JointID.ShoulderRight].Position.Z;

            elbowleftx = skeleton.Joints[JointID.ElbowLeft].Position.X;
            elbowlefty = skeleton.Joints[JointID.ElbowLeft].Position.Y;
            elbowleftz = skeleton.Joints[JointID.ElbowLeft].Position.Z;

            elbowrightx = skeleton.Joints[JointID.ElbowRight].Position.X;
            elbowrighty = skeleton.Joints[JointID.ElbowRight].Position.Y;
            elbowrightz = skeleton.Joints[JointID.ElbowRight].Position.Z;

            wristleftx = skeleton.Joints[JointID.WristLeft].Position.X;
            wristlefty = skeleton.Joints[JointID.WristLeft].Position.Y;
            wristleftz = skeleton.Joints[JointID.WristLeft].Position.Z;

            wristrightx = skeleton.Joints[JointID.WristRight].Position.X;
            wristrighty = skeleton.Joints[JointID.WristRight].Position.Y;
            wristrightz = skeleton.Joints[JointID.WristRight].Position.Z;

            hipcenterx = skeleton.Joints[JointID.HipCenter].Position.X;
            hipcentery = skeleton.Joints[JointID.HipCenter].Position.Y;
            hipcenterz = skeleton.Joints[JointID.HipCenter].Position.Z;

            hipleftx = skeleton.Joints[JointID.HipLeft].Position.X;
            hiplefty = skeleton.Joints[JointID.HipLeft].Position.Y;
            hipleftz = skeleton.Joints[JointID.HipLeft].Position.Z;

            hiprightx = skeleton.Joints[JointID.HipRight].Position.X;
            hiprighty = skeleton.Joints[JointID.HipRight].Position.Y;
            hiprightz = skeleton.Joints[JointID.HipRight].Position.Z;

            kneeleftx = skeleton.Joints[JointID.KneeLeft].Position.X;
            kneelefty = skeleton.Joints[JointID.KneeLeft].Position.Y;
            kneeleftz = skeleton.Joints[JointID.KneeLeft].Position.Z;

            kneerightx = skeleton.Joints[JointID.KneeRight].Position.X;
            kneerighty = skeleton.Joints[JointID.KneeRight].Position.Y;
            kneerightz = skeleton.Joints[JointID.KneeRight].Position.Z;

            float ax, ay, az, ax1, ay1, az1;

            ax = headx - shouldercx;
            ay = heady - shouldercy;
            az = headz - shouldercz;

            ax1 = spinex - shouldercx;
            ay1 = spiney - shouldercy;
            az1 = spinez - shouldercz;

            ang1 = calanglevector(ax, ay, az, ax1, ay1, az1);

            ax = wristleftx - elbowleftx;
            ay = wristlefty - elbowlefty;
            az = wristleftz - elbowleftz;

            ax1 = shoulderleftx - elbowleftx;
            ay1 = shoulderlefty - elbowlefty;
            az1 = shoulderleftz - elbowleftz;

            ang2 = calanglevector(ax, ay, az, ax1, ay1, az1);

            ax = wristrightx - elbowrightx;
            ay = wristrighty - elbowrighty;
            az = wristrightz - elbowrightz;

            ax1 = shoulderrightx - elbowrightx;
            ay1 = shoulderrighty - elbowrighty;
            az1 = shoulderrightz - elbowrightz;

            ang3 = calanglevector(ax, ay, az, ax1, ay1, az1);

            ax = hipcenterx - hipleftx;
            ay = hipcentery - hiplefty;
            az = hipcenterz - hipleftz;

            ax1 = kneeleftx - hipleftx;
            ay1 = kneelefty - hiplefty;
            az1 = kneeleftz - hipleftz;

            ang4 = calanglevector(ax, ay, az, ax1, ay1, az1);

            ax = hipcenterx - hiprightx;
            ay = hipcentery - hiprighty;
            az = hipcenterz - hiprightz;

            ax1 = kneerightx - hiprightx;
            ay1 = kneerighty - hiprighty;
            az1 = kneerightz - hiprightz;

            ang5 = calanglevector(ax, ay, az, ax1, ay1, az1);

            skeleton = (from s in skeletonsTrack.Skeletons
                                     where s.TrackingState == SkeletonTrackingState.Tracked
                                     select s).LastOrDefault();
           
            headx2 = skeleton.Joints[JointID.Head].Position.X;
            heady2 = skeleton.Joints[JointID.Head].Position.Y;
            headz2 = skeleton.Joints[JointID.Head].Position.Z;

            spinex2 = skeleton.Joints[JointID.Spine].Position.X;
            spiney2 = skeleton.Joints[JointID.Spine].Position.Y;
            spinez2 = skeleton.Joints[JointID.Spine].Position.Z;

            handleftx2 = skeleton.Joints[JointID.HandLeft].Position.X;
            handlefty2 = skeleton.Joints[JointID.HandLeft].Position.Y;
            handleftz2 = skeleton.Joints[JointID.HandLeft].Position.Z;

            handrightx2 = skeleton.Joints[JointID.HandRight].Position.X;
            handrighty2 = skeleton.Joints[JointID.HandRight].Position.Y;
            handrightz2 = skeleton.Joints[JointID.HandRight].Position.Z;

            shouldercx2 = skeleton.Joints[JointID.ShoulderCenter].Position.X;
            shouldercy2 = skeleton.Joints[JointID.ShoulderCenter].Position.Y;
            shouldercz2 = skeleton.Joints[JointID.ShoulderCenter].Position.Z;

            shoulderleftx2 = skeleton.Joints[JointID.ShoulderLeft].Position.X;
            shoulderlefty2 = skeleton.Joints[JointID.ShoulderLeft].Position.Y;
            shoulderleftz2 = skeleton.Joints[JointID.ShoulderLeft].Position.Z;

            shoulderrightx2 = skeleton.Joints[JointID.ShoulderRight].Position.X;
            shoulderrighty2 = skeleton.Joints[JointID.ShoulderRight].Position.Y;
            shoulderrightz2 = skeleton.Joints[JointID.ShoulderRight].Position.Z;

            elbowleftx2 = skeleton.Joints[JointID.ElbowLeft].Position.X;
            elbowlefty2 = skeleton.Joints[JointID.ElbowLeft].Position.Y;
            elbowleftz2 = skeleton.Joints[JointID.ElbowLeft].Position.Z;

            elbowrightx2 = skeleton.Joints[JointID.ElbowRight].Position.X;
            elbowrighty2 = skeleton.Joints[JointID.ElbowRight].Position.Y;
            elbowrightz2 = skeleton.Joints[JointID.ElbowRight].Position.Z;

            wristleftx2 = skeleton.Joints[JointID.WristLeft].Position.X;
            wristlefty2 = skeleton.Joints[JointID.WristLeft].Position.Y;
            wristleftz2 = skeleton.Joints[JointID.WristLeft].Position.Z;

            wristrightx2 = skeleton.Joints[JointID.WristRight].Position.X;
            wristrighty2 = skeleton.Joints[JointID.WristRight].Position.Y;
            wristrightz2 = skeleton.Joints[JointID.WristRight].Position.Z;

            hipcenterx2 = skeleton.Joints[JointID.HipCenter].Position.X;
            hipcentery2 = skeleton.Joints[JointID.HipCenter].Position.Y;
            hipcenterz2 = skeleton.Joints[JointID.HipCenter].Position.Z;

            hipleftx2 = skeleton.Joints[JointID.HipLeft].Position.X;
            hiplefty2 = skeleton.Joints[JointID.HipLeft].Position.Y;
            hipleftz2 = skeleton.Joints[JointID.HipLeft].Position.Z;

            hiprightx2 = skeleton.Joints[JointID.HipRight].Position.X;
            hiprighty2 = skeleton.Joints[JointID.HipRight].Position.Y;
            hiprightz2 = skeleton.Joints[JointID.HipRight].Position.Z;

            kneeleftx2 = skeleton.Joints[JointID.KneeLeft].Position.X;
            kneelefty2 = skeleton.Joints[JointID.KneeLeft].Position.Y;
            kneeleftz2 = skeleton.Joints[JointID.KneeLeft].Position.Z;

            kneerightx2 = skeleton.Joints[JointID.KneeRight].Position.X;
            kneerighty2 = skeleton.Joints[JointID.KneeRight].Position.Y;
            kneerightz2 = skeleton.Joints[JointID.KneeRight].Position.Z;

           // float ax, ay, az, ax1, ay1, az1;

            ax = headx2 - shouldercx2;
            ay = heady2 - shouldercy2;
            az = headz2 - shouldercz2;

            ax1 = spinex2 - shouldercx2;
            ay1 = spiney2 - shouldercy2;
            az1 = spinez2 - shouldercz2;

            ang21 = calanglevector(ax, ay, az, ax1, ay1, az1);

            ax = wristleftx2 - elbowleftx2;
            ay = wristlefty2 - elbowlefty2;
            az = wristleftz2 - elbowleftz2;

            ax1 = shoulderleftx2 - elbowleftx2;
            ay1 = shoulderlefty2 - elbowlefty2;
            az1 = shoulderleftz2 - elbowleftz2;

            ang22 = calanglevector(ax, ay, az, ax1, ay1, az1);

            ax = wristrightx2 - elbowrightx2;
            ay = wristrighty2 - elbowrighty2;
            az = wristrightz2 - elbowrightz2;

            ax1 = shoulderrightx2 - elbowrightx2;
            ay1 = shoulderrighty2 - elbowrighty2;
            az1 = shoulderrightz2 - elbowrightz2;

            ang23 = calanglevector(ax, ay, az, ax1, ay1, az1);

            ax = hipcenterx2 - hipleftx2;
            ay = hipcentery2 - hiplefty2;
            az = hipcenterz2 - hipleftz2;

            ax1 = kneeleftx2 - hipleftx2;
            ay1 = kneelefty2 - hiplefty2;
            az1 = kneeleftz2 - hipleftz2;

            ang24 = calanglevector(ax, ay, az, ax1, ay1, az1);

            ax = hipcenterx2 - hiprightx2;
            ay = hipcentery2 - hiprighty2;
            az = hipcenterz2 - hiprightz2;

            ax1 = kneerightx2 - hiprightx2;
            ay1 = kneerighty2 - hiprighty2;
            az1 = kneerightz2 - hiprightz2;

            ang25 = calanglevector(ax, ay, az, ax1, ay1, az1);
      
            saveCounter1++;
        }

        // Calculate the skeletal joint angle from x,y,z coordinates of joints
        private float calanglevector(float a1, float a2, float a3, float b1, float b2, float b3) {
            float ang,angtheta;
            float dd = a1 * b1 + a2 * b2 + a3 * b3;
            float aval =(float) Math.Sqrt(a1 * a1 + a2 * a2 + a3 * a3);
            float bval = (float)Math.Sqrt(b1 * b1 + b2 * b2 + b3 * b3);

            ang = (float) Math.Acos(dd / (aval * bval));
            angtheta= (float) (ang*180/Math.PI);
            return ang;
         }

        int[] persons;
        private int[] GetPersonIndexArr(byte[] depthFrame) {
            int[] personPixelIndexArr = new int[depthFrame.Length / 2];
            for (var i = 0; i < personPixelIndexArr.Length; i++)
            {
                personPixelIndexArr[i] = (int)(depthFrame[i * 2]&7);
            }
            persons = personPixelIndexArr.Distinct().ToArray();
            return personPixelIndexArr;
        }

        private byte[] GenerateColoredBytes(ImageFrame imageFrame) {
            int height = imageFrame.Image.Height;
            int width = imageFrame.Image.Width;

            byte[] depthData = imageFrame.Image.Bits;
            int[] personData = GetPersonIndexArr(depthData);
            byte[] colorFrame = new byte[imageFrame.Image.Height * imageFrame.Image.Width * 4];

            const int BlueIndex = 0;
            const int GreenIndex = 1;
            const int RedIndex = 2;

            var depthIndex = 0;

            for (var y = 0; y < height; y++)
            {
                var heightOffset = y * width;

                for (var x = 0; x < width; x++)
                {
                    var index = ((width - x - 1) + heightOffset) * 4;
                    var distance = GetDistanceWithPlayerIndex(depthData[depthIndex], depthData[depthIndex + 1]);
                    var intensity = CalculateIntensityFromDepth(distance);
                    colorFrame[index + BlueIndex] = 0;
                    colorFrame[index + GreenIndex] = 0;
                    colorFrame[index + RedIndex] = intensity;

                    if (personData[depthIndex/2] > 0)
                    {
                        int temp = persons.ToList<int>().IndexOf(personData[depthIndex / 2]);
                        intensity = CalculateIntensityFromDepth(distance);

                        switch (temp)
                        {
                            case 1:
                                colorFrame[index + BlueIndex] = intensity;
                                colorFrame[index + GreenIndex] = 0;
                                colorFrame[index + RedIndex] = 0;
                                break;
                            case 2:
                                colorFrame[index + BlueIndex] = 0;
                                colorFrame[index + GreenIndex] = intensity;
                                colorFrame[index + RedIndex] = 0;
                                break;
                            default:
                                colorFrame[index + BlueIndex] = 0;
                                colorFrame[index + GreenIndex] = 0;
                                colorFrame[index + RedIndex] = intensity;
                                break;
                        }
                    }
                    depthIndex += 2;
                }
            }
            return colorFrame;
        }

        const int MaxDepthDistance = 4000; //in mm
        const int MinDepthDistance = 500; //in mm

        private byte CalculateIntensityFromDepth(int distance) {
            
            return (byte)(255 - (255 * Math.Max(distance - MinDepthDistance, 0) / (MaxDepthDistance - MinDepthDistance)));
        }

        private int GetPlayerIndex(byte p) {
            return (int)(p & 7);
        }

        private int GetDistanceWithPlayerIndex(byte firstFrame, byte secondFrame) {
            int distance = (int)(firstFrame >> 3 | secondFrame << 5);
            return distance;
        }

        private void Grid_Loaded(object sender, RoutedEventArgs e) {

        }

        private void Window_Unloaded(object sender, RoutedEventArgs e) {

        }
        
        // Increase the elevation angle of the Kinect Sensor Camera
        private void button1_Click(object sender, RoutedEventArgs e) {
            try
            {
                this.cam.ElevationAngle += 5;
            }
            catch (InvalidOperationException)
            {
                MessageBox.Show("Failed to move Kinect motor.");
            }
            catch (ArgumentOutOfRangeException)
            {
                MessageBox.Show("Cannot move up further");
            }
        }

        // Decrease the elevation angle of the Kinect Sensor Camera
        private void button2_Click(object sender, RoutedEventArgs e) {
            try
            {
                this.cam.ElevationAngle -= 5;
            }
            catch (InvalidOperationException)
            {
                MessageBox.Show("Failed to move Kinect motor.");
            }
            catch (ArgumentOutOfRangeException)
            {
                MessageBox.Show("Cannot move further down.");
            }
        }

        // Start the capture the depth map frame video
        private void button3_Click(object sender, RoutedEventArgs e) {
            capture = true;
            fileNumber = 0;
            savePath = textBox1.Text;
            skipFrame = (int)slider1.Value;
        }
        
        // Stop the capture of depth map frame video
        private void button4_Click(object sender, RoutedEventArgs e) {
            fileNumber = 0;
            capture = false;            
        }        
    }
}