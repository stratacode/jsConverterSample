
public class Foo {
   // This annotation causes the main method to be invoked when the web page loads
   @sc.obj.MainSettings
   public static void main(String[] args) {
      
      System.out.println("*** running Foo: " + new Bar().sum100());
   }
}
