Tạo chương trình thực hiện việc mượn sách. Mỗi đầu sách chỉ có một quyển. Mỗi người khi mượn sách, hệ thống kiểm tra xem quyển sách cần mượn có ai đó đã mượn chưa, nếu có người mượn rồi thì hiện thị thông báo “I don't have the book”, còn lại sẽ thực hiện được việc mượn sách.

Vậy trong trường hợp này, đối tượng sách được tạo ra là duy nhất. Sử dụng mẫu thiết kế Singleton để minh hoạ ví dụ trên.



--------------------note-----------------
Java Singleton thuộc vào 1 trong 5 design pattern của nhóm Creational Design Pattern.

Singleton là một mẫu thiết kế creational cho phép bạn đảm bảo rằng một lớp chỉ có một đối tượng thể hiện và cung cấp truy cập đối tượng này với phạm vi toàn ứng dụng.
Singleton đảm bảo chỉ duy nhất môt thể hiện mới (new instance) được tạo ra và nó sẽ cung cấp cho bạn một phương thức để truy cập đến thực thể đó.
Singleton giải quyết các vấn đề như:

Làm thế nào có thể được đảm bảo rằng một lớp chỉ có một đối tượng
Làm thế nào có thể truy cập dễ dàng một thể hiện duy nhất của một lớp
Làm thế nào để một lớp kiểm soát sự hiện thân của nó
Làm thế nào có thể hạn chế số lượng các thể hiện của một lớp
Cấu trúc
Một Singleton Pattern thường là 1 class (Class Singleton) có các đặc điểm:

Phương thức khởi tạo private để ngăn cản việc tạo thể hiện của class từ các class khác
Biến private static của class, nó là thể hiện duy nhất của class.
Có một phương thức là public static để trả về thể hiện của class.