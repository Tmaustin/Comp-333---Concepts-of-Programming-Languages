/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package random;
import java.util.Scanner;
/**
 *
 * @author Taylor
 */
public class FortranToJava {
    public static void main(String[] args) {
        double values [][]=new double[50][2];
        Scanner input = new Scanner(System.in);
        double S1=0,S2=0,S3=0,S4=0,S5=0,T,S,B,R,BBAR;
        int N;
        System.out.println("*   *   *  LINEAR REGRESSION ANALYSIS  *   *   *");
        System.out.println("HOW MANY PAIRS TO BE ANALYZED?");
        N = input.nextInt();
        if (N > 50) {
            System.out.println("'At present this program can only handle 50 data pairs.'");
            System.exit(1);
        }
        String[] numbers=new String[2];
        System.out.println("Enter one pair at a time and separate X from Y with a comma.");
	//#1
        
        for(int x=1;x<=N;x++){
            System.out.println("Enter pair number "+x+" : ");
            String Coordinates = input.next();
            numbers = Coordinates.split("\\s*,\\s*");
            values[x-1][0]=Double.parseDouble(numbers[0]);
            values[x-1][1]=Double.parseDouble(numbers[1]);
        }
        
        System.out.println("Would you like to print the data? (Y,N)");
        String PrintData = input.next();
        if(PrintData.equals("Y")||PrintData.equals("y")){
            for(int x=1;x<=N;x++){
                System.out.println("DATA PAIR "+x+" ("+values[x-1][0]+","+values[x-1][1]+")");
            }
        }
        for(int x=1;x<=N;x++){
            S1=S1+values[x-1][0];
            S2=S2+values[x-1][1];
            S3=S3+values[x-1][0]*values[x-1][1];
            S4=S4+values[x-1][0]*values[x-1][0];
            S5=S5+values[x-1][1]*values[x-1][1];
        }

        T=N*S4-S1*S1;
        S=(N*S3-S1*S2)/T;
        B=(S4*S2-S1*S3)/T;
        
        R=(N*S3-S1*S2)/(Math.sqrt(Math.abs(((N*S4-Math.pow(Math.abs(S1), 2)))*(N*S5-Math.pow(Math.abs(S2), 2)))));
        
        System.out.println("SLOPE: "+S);
        System.out.println("INTERCEPT: "+B);
        
        
        System.out.print("EQUATION FOR THE BEST LINEAR FIT : ");
        BBAR=Math.abs(B);
        if(Math.abs(B)==B){
            System.out.println(" Y(X) = "+S+" * X + "+BBAR);
        }
        else{
            System.out.println("Y(X) = "+S+" * X - "+BBAR);
        }
        System.out.println("LINEAR CORRELATION COEFFICIENT = "+R);
        System.out.println("LINEAR... Execution completed");
    }
}
