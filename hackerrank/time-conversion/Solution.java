import java.io.*;
import java.util.*;
import java.util.stream.*;
import java.time.format.*;
import java.time.*;

public class Solution {
    public static void main(String[] args) throws IOException {
        final List<String> allReadLines = new ArrayList<String>();

        final BufferedReader in = new BufferedReader(new InputStreamReader(System.in));
        String s;
        while ((s = in.readLine()) != null && s.length() != 0) {
            allReadLines.add(s);
        }
        System.out.println(run(allReadLines));
    }

    public static String run(List<String> stream) {
        final String input = stream.get(0);
        final DateTimeFormatter inputFormatter = DateTimeFormatter.ofPattern("hh:mm:ssa");
        final DateTimeFormatter outputFormatter = DateTimeFormatter.ofPattern("HH:mm:ss");
        final LocalTime dateTime = LocalTime.parse(input, inputFormatter);

        return dateTime.format(outputFormatter);
    }
}
