/*Recursive descent parser for expressions
 * Jamey Dogom
 * Taylor Austin
 * Comp 333
 */

import java.util.*;

public class RecDescentParser {
    public char nextchar;
    public String inputString;
    private int pos;

    public RecDescentParser(String s) {
        inputString = s;
        pos = 0;
        System.out.println("\nParsing:  " + s);
    }

    public void start() throws Exception // Don't change
        {
            try {
                getChar();
                S();
                System.out.println("Successful parse");
            } catch (Exception e) {
                System.out.println("Unsuccessful parse");
            }

        }

    public void getChar() throws Exception // Don't change
        {
            // skip over blank chars
            while (pos < inputString.length() && inputString.charAt(pos) == ' ') {

                pos++;
            }

            if (pos < inputString.length()) {
                nextchar = inputString.charAt(pos);
                System.out.println("getChar:  " + pos + "  " + nextchar);
                pos++;
            } else
                error();

        }

    public void S() throws Exception {
        STList();
        match('$');
    }

    public void ST() throws Exception {
        N();
        match('=');
        E();
    }

    public void STList() throws Exception {
        ST();
        if (nextchar == ';') {
            match(';');
            STList();
        }

    }

    public void N() throws Exception {
        if (Character.isLetter(nextchar)) {
            match(nextchar);
            return;
        } else
            error();
    }

    public void E() throws Exception {

        T();
        if (nextchar == '+') {
            match('+');
            E();
        }
        if (nextchar == '-') {
            match('-');
            E();
        }

    }

    public void T() throws Exception {

        F();
        if (nextchar == '*') {
            match('*');
            T();
        }
        if (nextchar == '/') {
            match('/');
            T();
        }
    }

    public void F() throws Exception {

        if (Character.isLetterOrDigit(nextchar)) {
            if (Character.isLetter(nextchar)) {
                match(nextchar);
            } else {
                match(nextchar);
                I();
            }
            return;

        } else if (nextchar == '(') {
            match('(');
            E();
            match(')');
        } else
            error();
    }

    public void I() throws Exception {
        if (Character.isDigit(nextchar)) {
            match(nextchar);
            I();
            return;
        }
    }

    public void error() throws Exception // Don't change
        {
            System.out.println("Syntax error at position : " + pos + "  with character: " + nextchar);
            throw new Exception("Syntax Error");
        }

    public void match(char u) throws Exception // Don't change
        {
            if (nextchar == u) {
                if (u != '$')
                    getChar();
                return;
            } else
                error();
        }

    public static void main(String[] args) throws Exception {

        RecDescentParser rdp = new RecDescentParser(
            "x = y * ( a + 2 - c) + A $");
        rdp.start();

        RecDescentParser rdp2 = new RecDescentParser("z = a + (b + 1)) $");
        rdp2.start();

        RecDescentParser rdp3 = new RecDescentParser(
            "u = 7 ; v = a + 8 ; x = 3$");
        rdp3.start();

        RecDescentParser rdp4 = new RecDescentParser(
            "c = z + 341 + 5 ; x = 100$");
        rdp4.start();
    }

}