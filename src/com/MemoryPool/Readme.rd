Vấn đề cân bằng giữa tốc độ và sử dụng bộ nhớ luôn là vấn đề đau đầu đối với lập trình viên. Khi phải đối mặt với vấn đề này, người lập trình phải cân nhắc xem nên ưu tiên tốc độ hay bộ nhớ. Đối với những ứng dụng chạy theo thời gian thực thì bộ nhớ luôn là vấn đề hàng đầu, bởi trong suốt vòng đời của ứng dụng, các đối tượng liên tục được tạo và hủy gây phân mảnh vùng nhớ, do vậy nếu quản lý bộ nhớ không tốt sẽ gây lãng phí tài nguyên dẫn đến hệ thống nhanh chóng rơi vào tình trạng cạn bộ nhớ. Đối với việc lập trình cho các thiết bị hạn chế về tài nguyên thì cần phải xem trọng cả hai. Việc tìm ra điểm cân bằng giữa tốc độ thực thi và sử dụng bộ nhớ là một công việc không phải lúc nào cũng dễ dàng.

Phần này sẽ cung cấp cho các bạn một giải pháp để tham khảo trong việc quản lý bộ nhớ sử dụng Memory Pool. Memory Pool là một kỹ thuật giúp khai thác vùng nhớ một cách hiệu quả bằng cách khởi tạo một vùng nhớ cố định sau đó quản lý việc cấp phát và tái chế các đối tượng trong vùng nhớ này.

Để hiểu được cách mà Pool hoạt động, ta thử đặt một tình huống giả định sau đây: Một đạo diễn phim nhận được một kịch bản trong đó có hơn 100 nhân vật, nhưng thực tế ông chỉ có 10 diễn viên trong tay. Làm thế nào để hoàn thành bộ phim có hơn 100 nhân vật mà trong tay chỉ có 10 diễn viên? Câu trả lời trong trường hợp này đơn giản là: cho mỗi diễn viên đóng nhiều vai khác nhau.

Thử một tình hống khác: Làm thế nào để tiêu diệt 1000 máy bay địch mà trong tay bạn chỉ có 10 viên đạn? :D. Các bạn sẽ thắc mắc rằng thực tế làm sao mà làm được như vậy, nhưng nếu bạn đã từng chơi một game đi cảnh bắn súng kiểu như SkyForce thì điều này hoàn toàn là sự thật đứng dưới góc độ của lập trình viên, còn tất nhiên người chơi thì vẫn chỉ biết bắn và bắn mà không hề biết rằng mình chỉ có 10 viên đạn!!! Tình huống này so với tình huống trên là không khác gì nhau nếu nhìn nhận dưới góc độ của Pool.

Hãy code một game đơn giản giúp minh họa cách hoạt động của memory pool như sau: Trò chơi với một khẩu súng máy có 1000 viên đạn, bắn liên tục vào một bia đích cách đó 10m. Trò chơi sẽ kết thúc khi không còn viên đạn nào được bắn ra.

Hướng dẫn
Bước 1: Tạo lớp Bullet

Lớp Bullet đại diện cho một viên đạn, có một thuộc tính là vị trí của viên đạn đó.

Biến count là một biến static được dùng để đếm số lượng đạn đã được tạo ra.

public class Bullet {
    public static int count = 0;
    private int position;

    public int getPosition() {
        return position;
    }

    public void setPosition(int position) {
        this.position = position;
    }

    public Bullet() {
        count++;
    }

    public void move() {
        position++;
    }
}
Bước 2: Tạo lớp abstract MemoryPool

Lớp MemoryPool cung cấp các phương thức:

newItem() được gọi để cung cấp một đối tượng
freeItem() được gọi để giải phóng một đối tượng
abstract allocate() sẽ được triển khai trong lớp con để tạo ra một đối tượng hoàn toàn mới
public abstract class MemoryPool<T> {

    private LinkedList<T> free_items = new LinkedList<>();

    public void freeItem(T item) {
        free_items.add(item);
    }

    protected abstract T allocate();

    public T newItem() {
        T out = null;
        if (free_items.size() == 0) {
            out = allocate();
        } else {
            out = free_items.getFirst();
            free_items.removeFirst();
        }
        return out;
    }
}
Bước 3: Tạo lớp BulletPool kế thừa từ MemoryPool

public class BulletPool extends MemoryPool<Bullet> {
    @Override
    protected Bullet allocate() {
        return new Bullet();
    }
}
Bước 4: Tạo lớp Gun mô phỏng một khẩu súng

Lớp Gun có các phương thức

fireInPool(): minh hoạ cho trường hợp bắn súng sử dụng các viên đạn từ trong Pool
fire(): minh hoạ cho trường hợp bắn súng không sử dụng các viên đạn từ trong Pool mà tự tạo viên đạn mới

public class Gun {
    private int bulletCount=1000;

    public void fireInPool() {
        BulletPool pool = new BulletPool();
        List<Bullet> plist = new ArrayList<>();
        for(int i = 0; i < bulletCount; i++) {
            Bullet p = pool.newItem();
            p.setPosition(0);
            plist.add(p);
            for(int j=0; j < plist.size(); j++) {
                Bullet pp = plist.get(j);
                pp.move();
                System.out.print("-" + pp.getPosition());
                if(pp.getPosition() == 10) {
                    pool.freeItem(pp);
                    plist.remove(pp);
                }
            }
            System.out.println();
        }
    }

    public void fire() {
        List<Bullet> plist = new ArrayList<>();
        for(int i = 0; i < bulletCount; i++) {
            Bullet p = new Bullet();
            p.setPosition(0);
            plist.add(p);
            for(int j=0; j < plist.size(); j++) {
                Bullet pp=plist.get(j);
                pp.move();
                System.out.print("-" + pp.getPosition());
                if(pp.getPosition() == 10) {
                    plist.remove(pp);
                }
            }
            System.out.println();
        }
    }
}
Bước 5: Viết hàm main() để minh hoạ trường hợp bắn súng sử dụng phương thức fire()

public class Main {

    public static void main(String[] args) {
        Gun gun=new Gun();
        System.out.println("Start");
        gun.fire();
        System.out.println("Game over");
        System.out.println("Tocal bullet created: " + Bullet.count);
    }
}
Chạy và quan sát kết quả:

Game over
Tocal bullet created: 1000
Như vậy, có 1000 đối tượng Bullet đã được tạo ra.

Bước 6: Thay đổi lời gọi phương thức gun.fire() thành gun.fireInPool()

public class Main {

    public static void main(String[] args) {
        Gun gun=new Gun();
        System.out.println("Start");
        gun.fireInPool();
        System.out.println("Game over");
        System.out.println("Tocal bullet created: " + Bullet.count);
    }
}
Chạy và quan sát kết quả:

Game over
Tocal bullet created: 11
Trong trường hợp này, chỉ có một số lượng hạn chế là 11 đối tượng Bullet được tạo ra. Như vậy việc sử dụng Pool đã giúp chúng ta tiết kiệm được một số lượng khá lớn tài nguyên từ việc tái sử dụng các đối tượng đã được sử dụng trước đó.