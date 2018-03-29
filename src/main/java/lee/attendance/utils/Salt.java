package lee.attendance.utils;

public class Salt {
    public static String salt(){
        String resource = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
        char[] rands = new char[6]; 
        StringBuffer buffer = new StringBuffer();
        for (int i = 0; i < rands.length; i++) 
        { 
            int rand = (int) (Math.random() * resource.length()); 
            buffer.append(resource.charAt(rand)); 
        } 
        return buffer.toString();
    }
}
