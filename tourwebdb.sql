create database tourweb;

use tourweb;

-- Create all table
CREATE TABLE account (
  id int auto_increment,
  email varchar(100) not null unique,
  username varchar(100) not null,
  password varchar(100) not null,
  status varchar(5),
  role varchar(5) not null,
  phone_number int not null unique,
  fullname varchar(100) character set utf8mb4 not null,
  PRIMARY KEY (id)
);

CREATE TABLE available_tour (
  id int auto_increment,
  price int not null,
  booked int default 0, -- This is to count number of tourist had booked a tour
  max_number_tourist int not null, -- This is to count max number of tourist can book 
  start_date date not null,
  view int,
  end_date date not null,
  tour_name text,
  discount int,
  start_discount date,
  end_discount date,
  status varchar(5),
  start_place varchar(50) character set utf8mb4 not null,
  description text not null,
  image text,
  PRIMARY KEY (id)
);
	
CREATE TABLE custom_tour (
  id int auto_increment,
  user_id int not null,
  place int not null,
  description text,
  start_date date not null,
  end_date date,
  affordable_price int,
  number_children int,
  number_adult int,
  status varchar(5),
  price int,
  PRIMARY KEY (id),
  FOREIGN KEY (user_id) REFERENCES account(id)
);

CREATE TABLE event (
  id int auto_increment,
  user_id int not null,
  tour_id int not null,
  detail text,
  image text,
  url text,
  PRIMARY KEY (id)
);

CREATE TABLE post (
  id int auto_increment,
  user_id int not null,
  post_name varchar(100) character set utf8mb4 not null,
  short_description text,
  content text,
  image text,
  post_date datetime not null,
  PRIMARY KEY (id),
  FOREIGN KEY (user_id) REFERENCES account(id)
);

CREATE TABLE comment (
  id int auto_increment,
  user_id int not null,
  post_id int not null,
  content text,
  reply_date datetime not null,
  PRIMARY KEY (id),
  FOREIGN KEY (post_id) REFERENCES post(id),
  FOREIGN KEY (user_id) REFERENCES account(id)
);

CREATE TABLE booking (
  user_id int not null,
  tour_id int not null,
  number_tourist int,
  note text,
  id int primary key auto_increment,
  FOREIGN KEY (user_id) REFERENCES account(id),
  FOREIGN KEY (tour_id) REFERENCES available_tour(id)
);

-- trigger to update number of booking
DELIMITER //
CREATE TRIGGER update_booked_count AFTER INSERT ON booking
FOR EACH ROW
BEGIN
    UPDATE available_tour
    SET booked = booked + NEW.number_tourist
    WHERE id = NEW.tour_id;
END;
//
DELIMITER ;
-- add status column to booking
ALTER TABLE booking
ADD status varchar(20) DEFAULT 'Chờ thanh toán';
ALTER TABLE booking
ADD created_date DATETIME default CURRENT_TIMESTAMP;

-- Example data for available tour 
INSERT INTO available_tour (tour_name, start_date, end_date, start_place, description, price, max_number_tourist,
status)
VALUES ('Hà Nội - Hạ Long - Yên Tử - Ninh Bình - Bái Đính - Tràng An', '2023-12-05', '2023-12-09', 'TP. Hồ Chí Minh', '
<pre><h2>Ngày 1 - HÀ NỘI – LÀO CAI - SAPA (Ăn trưa, tối)</h2>
06h15 Xe và hướng dẫn viên đón đoàn tại Điểm hẹn - Vietravel Hanoi - Số 03 Phố Hai Bà Trưng, Hoàn Kiếm khởi hành đi Sapa.

Trên đường đi quý khách tham quan:

- Đền ông Hoàng Bảy - đền Bảo Hà: ngôi đền linh thiêng gắn với truyền thuyết về Ông Hoàng Bảy. Nơi đây đang dần trở thành một địa điểm du lịch tâm linh nổi tiếng nằm trên con đường đến với Sa Pa, Lào Cai. Nơi đây được rất nhiều người biết đến bởi sự linh thiêng kỳ lạ.

Quý khách ăn trưa, tiếp tục di chuyển đến Sapa đến nơi quý khách nhận phòng nghỉ ngơi và tham quan:

- Đỉnh đèo Ô Quy Hồ: một trong “Tứ đại đỉnh đèo” phía Bắc (không bao gồm vé tham quan Thác Bạc, Cầu Kính rồng mây, Cổng Trời...)

- Núi Hàm Rồng: ngắm cảnh và chụp ảnh thị trấn Sapa trong sương, thăm vườn Lan 1-2 khoe sắc, vườn Lê, vườn Táo Mèo, Vườn hoa Trung Tâm, Hòn Đá Gãy, Cổng Trời, Đầu Rồng, Hòn Cá Sấu, Khu Thiên Thạch Lâm, Hòn Phật Bà, Sân Mây, Tháp truyền hình... 

Ăn tối tại nhà hàng địa phương. 

Quý khách tự do thăm quan:

- Nhà Thờ Đá Sapa: dấu ấn kiến trúc của người Pháp còn lại vẹn toàn nhất tại Sa Pa, tự do thưởng thức đặc sản vùng cao như: thịt lợn cấp nách nướng, trứng nướng, rượu táo mèo, giao lưu với người dân tộc Mông, Dao.

<h3>Nghỉ đêm tại Sapa</h3>
<h2>Ngày 2 - SAPA – FANSIPAN HÙNG VĨ – BẢN CÁT CÁT (Ăn sáng, tối)</h2>
Đoàn ăn sáng tại khách sạn sau đó:
07:00 Xe và HDV đưa đoàn đến Sun PLaza, Quý khách trải nghiệm đến khu du lịch Fansipan Legend bằng Tàu hỏa leo núi Mường Hoa hiện đại nhất Việt Nam với tổng chiều dài gần 2000m, thưởng ngoạn bức tranh phong cảnh đầy màu sắc của cánh rừng nguyên sinh, thung lũng Mường Hoa.
•    Chinh phục đỉnh núi Fansipan với độ cao 3.143m hùng vĩ bằng cáp treo (chi phí cáp treo  tự túc). 
•    Lễ Phật tại chùa Trình hay cầu phúc lộc, bình an cho gia đình tại Bích Vân Thiền Tự trong hệ thống cảnh quan tâm linh trên đỉnh Fansipan. 
Đoàn tự túc ăn trưa chiều tham quan:
•    Bản Cát Cát - đường vào bản quanh co một bên là thung lũng Mường Hoa với những thửa ruộng bậc thang màu mỡ được tô điểm bởi màu xanh của ngô và lúa, thăm những nếp nhà của người Mông, Dao, Giáy… Quý khách còn có cơ hội thưởng thức những màn biểu diễn đặc sắc của các dân tộc nơi đây.
Ăn tối tại nhà hàng. 
Tự do tham quan Sapa về đêm, Quý khách có thể thưởng thức khoai nướng, trứng nướng – mang đậm tính đặc sắc vùng miền.

<h3>Nghỉ đêm tại Sapa.</h3>
<h2>Ngày 3 - SECRET GARDEN/MOANA - HÀ NỘI (Ăn sáng, trưa)</h2>
Quý khách ăn sáng, trả phòng khách sạn sau đó tham quan:

- Secret Garden/Moana: điểm sống ảo mới toanh giữa lòng phố núi Sapa đang làm mưa làm gió với “giường trên không” và “nhà bong bóng”. Hãy nghĩ đến cảnh bạn sẽ được nằm ườn trên chăn bông bồng bềnh, view “khách sạn ngàn sao”, có thể nằm ngắm trời ngắm mây, nhìn thẳng ra những dãy núi mờ ảo trong mây.

Đoàn ăn trưa tại nhà hàng. Quý khách lên xe trở về Hà Nội.

Về đến Hà Nội, chia tay Quý khách. Kết thúc chương trình.
</pre>', 6990000, 9, 'on'),

('Đông Bắc: Hà Giang - Lũng Cú - Đồng Văn - Mã Pí Lèng - Mèo Vạc - Cao Bằng - Thác Bản Giốc - Hồ Ba Bể', '2023-12-10',
'2023-12-16', 'TP. Hồ Chí Minh', '
<pre><h2>Ngày 1 - SB NỘI BÀI - HÀ GIANG 02 bữa ăn: (Trưa, Tối)</h2>
    Quý khách tập trung tại sân bay Tân Sơn Nhất (Ga nội địa), hướng dẫn viên hỗ trợ khách làm thủ tục đáp chuyến bay đi Hà Nội. Đến sân bay Nội Bài, xe và HDV của V Travel đón Quý khách đi Hà Giang - nơi có chè Shan Tuyết, rượu mật ong và thắng cố, xứ sở của đào phai, hoa lê, truyền thống và náo nhiệt trong buổi chợ phiên. Đến nơi, Quý khách chụp hình lưu niệm Cột mốc số 0 - đánh dấu điểm khởi công của con đường Hạnh Phúc nối Hà Giang và 4 huyện vùng cao nguyên đá
    Xe đưa Quý khách về khách sạn nhận phòng và dùng cơm chiều, hoặc tự do thưởng thức món Chè Shan Tuyết, mật ong Bạc Hà và ấm bụng với món cháo Ấu Tẩu.
    <h3>Nghỉ đêm tại Hà Giang.</h3>
    <h2>Ngày 2 - HÀ GIANG - QUẢN BẠ - YÊN MINH – ĐỒNG VĂN 03 bữa ăn: (Sáng, Trưa, Tối)</h2>
    Ăn sáng và trả phòng khách sạn. Xe và hướng dẫn viên khởi hành đưa Quý khách khám phá Công viên địa chất toàn cầu Cao nguyên đá Đồng Văn (Bao gồm địa giới hành chính của 4 huyện phía Bắc tỉnh Hà Giang với diện tích 2.356 km2) với những điểm check-in đặc sắc:
    Ngắm Núi Đôi Quản Bạ - biểu tượng vẻ đẹp của vùng cao nguyên đá, Quý khách đi bộ lên Cổng trời Quản Bạ ngắm toàn bộ vẻ đẹp thơ mộng của thị trấn Tam Sơn và hít thở bầu không khí mát mẻ trong lành quanh năm.
    Sau khi ăn trưa, Quý khách tiếp tục hành trình đi tham quan:
    Dốc Thẩm Mã – những con đường đèo khúc khuỷu, quanh co tựa như một dải lụa uốn lượn mềm mại trải dài theo triền núi.
    Làng văn hóa Lũng Cẩm – Thung lũng Sủng Là: được mênh danh là “ đóa hoa hồng” trong lòng cao nguyên đá luôn cuốn hút du khách bởi vẻ đẹp hết sức bình dị, mộc mạc. Nơi đây từng là bối cảnh quay bộ phim đoạt giải phim truyện nhựa xuất sắc nhất của Hội điện ảnh Việt Nam - phim “Chuyện của Pao”, du khách tìm hiểu văn hóa người Mông.
    Khu kiến trúc nghệ thuật nhà Vương (Dinh Vua Mèo), công trình kiến trúc đẹp, hiếm có và rất độc đáo của vùng cao nguyên núi đá.
    Chinh phục Cột cờ Lũng Cú hay còn gọi là đỉnh núi Rồng, nơi địa đầu Cực Bắc Tổ Quốc với lá cờ 54m2 tượng trưng cho 54 dân tộc anh em. Từ trên cao, Quý khách sẽ ngắm những mảng xanh mát của ruộng bậc thang và các bản làng Lô Lô Chải, Thèn Pả, xa xa có 2 hồ nước phía xa, nằm đối xứng nhau được người dân nơi đây ví như “mắt rồng”.
    Quý khách dùng cơm chiều và nhận phòng khách sạn nghỉ ngơi.
    <h3>Nghỉ đêm tại Đồng Văn hoặc Mèo Vạc</h3>     
    <h3>Ghi chú: Điểm tham quan Cột Cờ Lũng Cú sẽ không tham quan được trong trường hợp thời tiết không thuận lợi.</h3>
    <h2>Ngày 3 - ĐỒNG VĂN – MÈO VẠC – CAO BẰNG 03 bữa ăn: (Sáng, Trưa, Tối)</h2>
    Quý khách ăn sáng, trả phòng khách sạn. Xe đưa Quý khách đi tham quan:
    Đèo Mã Pì Lèng: Một trong Tứ đại đỉnh đèo hùng vĩ của miền Bắc Việt Nam dài 24km, dừng chân nghỉ ngơi, chụp ảnh nơi bị chia cắt về địa hình sâu nhất của Việt Nam. Trên đường dừng chụp hình tại tượng đài Thanh Niên trước Bảo tàng Con Đường Hạnh Phúc, Mã Pí Lèng café (chi phí tự túc), ngắm con đường hạnh phúc và toàn cảnh dòng sông Nho Quế từ trên cao.
    Dừng chụp hình lưu niệm tại Làng Văn hóa Du lịch Cộng đồng Pả Vi, nằm dưới chân đèo Mã Pì Lèng, bên cạnh dòng sông xanh nho Quế. Nơi đây thu hút sự quan tâm của du khách bởi thiết kế ấn tượng của cổng chào hình dáng chiếc khèn Mông khổng lồ, những homestay mang đậm nét văn hóa, phong cách của người Mông,…  
    Tiếp tục hành trình đến Cao Bằng, Quý khách dừng tại Bảo Lạc dùng cơm trưa tại nhà hàng địa phương. Đến Cao Bằng, Quý khách nhận phòng nghỉ ngơi và dùng cơm tối.
    <h3>Nghỉ đêm tại Cao Bằng.</h3>
    <h2>Ngày 4 - THÁC BẢN GIỐC – ĐỘNG NGƯỜM NGAO – LÀNG ĐÁ KHUỔI KY 03 bữa ăn: (Sáng, Trưa, chiều)</h2>
    Quý khách ăn sáng, trả phòng khách sạn. Xe khởi hành đưa Quý khách đi tham quan:
    Thác Bản Giốc - một trong những thác nước đẹp nhất của Việt Nam có đường ranh giới tự nhiên với Trung Quốc. Thác nước đẹp và hùng vỹ với dòng nước cuồn cuộn chảy quanh năm bắt nguồn từ dòng sông Quây Sơn nước xanh ngắt một màu ngọc Bích. Đẹp nhất vào mùa lúa chín (tháng 9) khung cảnh đường vào thác sáng rực một màu vàng óng và dòng nước trắng xóa mềm mại như tóc tiên càng làm khung cảnh thêm nên thơ, hùng vỹ.
    Chùa Phật Tích Trúc Lâm Bản Giốc: được xây dựng theo lối kiến trúc thuần Việt trên diện tích 3 ha, đây là ngôi chùa đầu tiên được xây dựng tại nơi biên cương phía Bắc của tổ quốc.
     Quý khách dùng cơm trưa và tiếp tục tham quan:
    Động Ngườm Ngao - một động lớn được hình thành từ sự phong hoá lâu đời của đá vôi; bước vào động, du khách như bước vào một thế giới kỳ ảo, choáng ngợp trước những dải thạch nhũ muôn màu, những tượng đá quyến rũ với nhiều kiểu dáng khác nhau mang dáng dấp hình người, cây rừng, súc vật..., các nhũ đá thả từ trên xuống hay mọc từ dưới đất lên vô cùng sống động
    Làng Đá Khuổi Ky: với một ý niệm đá là khởi nguồn của sự sống và trung tâm của vũ trụ mà người Tày ở Trùng Khánh luôn gìn giữ ngôi nhà sàn, nơi sinh hoạt xung quanh mình là đá, điều đó đã tạo nên điểm nhấn cho ngôi làng nhìn từ xa như một bức tranh vững chãi giữa mây trời núi non hùng vỹ. Đến đây vào homestay và thưởng thức tách café giữa khung cảnh núi rừng sẽ cho quý khách cảm giác bình yên đến lạ.
    Xe đưa Quý khách về thành phố Cao Bằng dùng cơm tối tại nhà hàng địa phương, mua sắm đặc sản địa phương: Miến dong, thạch đen, lạp xưởng, ... Quý khách nhận phòng khách sạn nghỉ ngơi.
    <h3>Nghỉ đêm tại Cao Bằng.</h3>
    <h2>Ngày 5 - CAO BẰNG – KHU DI TÍCH PÁC PÓ – BA BỂ 03 bữa ăn: (Sáng, Trưa, chiều)</h2>
    Quý khách ăn sáng và trả phòng khách sạn. Xe khởi hành đưa Quý khách tham quan:
    Khu di tích Pác Pó - nơi chủ tịch Hồ Chí Minh từng sống và làm việc với khung cảnh nên thơ, hữu tình. Dòng suối trong xanh, thơ mộng trước cửa hang được Bác đặt tên là Suối Lê Nin, ngọn núi hùng vĩ cạnh bên là Núi Các Mác
    
    Khu di tích Kim Đồng - Nơi ghi nhớ anh hùng liệt sỹ có công bảo vệ cán bộ cách mạng trong thời kỳ kháng chiến.
    
    Sau khi dùng cơm trưa, Quý khách khởi hành đi Bắc Kạn, nhận phòng và nghỉ ngơi tại Ba Bể.
    <h3>Nghỉ đêm tại Ba Bể.</h3>
    <h2>Ngày 6 - BA BỂ - BẮC CẠN – SB NỘI BÀI 02 bữa ăn: (Sáng, Trưa)</h2>
    Quý khách ra bến thuyền tham quan:
    Hồ Ba Bể (2 tiếng) – Khám phá bức tranh sơn thủy hữu tình vô cùng sống động, mặt nước hồ trong xanh như gương làm quyến rũ biết bao du khách làm quyến rũ biết bao du khách, thiên nhiên và con người như hòa quyện vào nhau, ngắm Ao Tiên, Đền An Mã, hòn Bà Góa. Thuyền dừng trên mặt hồ, Quý khách giao lưu hát then và đàn tính của người Tày, hoặc tham gia chèo thuyền kayak xung quanh đảo Bà Góa (chi phí tự túc).
    Đoàn khởi hành về Hà Nội. Đến sân bay Nội Bài, Hướng dẫn viên hỗ trợ Quý khách làm thủ tục đáp chuyến bay về Tp.HCM. Chia tay Quý khách và kết thúc chương trình du lịch tại sân bay Tân Sơn Nhất.
</pre>', 10690000, 3, 'on'),

('Hà Giang - Lũng Cú - Đồng Văn - Nơi đá nở hoa', '2023-12-14', '2023-12-18', 'Hà Nội', '
<pre><h2>Ngày 1 - HÀ NỘI – TUYÊN QUANG – HÀ GIANG (Ăn trưa, chiều)</h2>
    06h30 Xe và hướng dẫn viên đón quý khách tại V Travel Hanoi - Số 3 Hai Bà Trưng, Hoàn Kiếm, Hà Nội khởi hành đi Hà Giang, trên đường dừng tham quan: 
    - Đền Thác Cái - Được xây dựng từ thế kỷ XV, ngôi đền cổ kính bắt nguồn từ tục thờ Mẫu của nhân dân Lạc Việt có từ xa xưa trong lịch sử. Sau lưng đền là đồi núi, mặt trước hướng về phía sông Lô tạo nên khí thiêng sơn thủy hội tụ, bốn mùa thời tiết trong lành mát mẻ, tĩnh mịch.
    Quý khách dùng cơm tối và nhận phòng khách sạn nghỉ ngơi.  
    <h3>Ngủ đêm tại khách sạn Hà Giang</h3>
    <h2>Ngày 2 - HÀ GIANG – LŨNG CÚ – ĐỒNG VĂN (Ăn sáng, trưa, chiều)</h2>
    Quý khách trả phòng, ăn sáng. Xe và hướng dẫn viên đưa Quý khách đi thị trấn Đồng Văn tham quan:
    
    Đoàn dừng chân nghỉ ngơi tại Cổng trời Quản Bạ - Nơi tiếp giáp giữa trời và đất, ngắm thị trấn Tam Sơn và danh thắng Núi Đôi.
    Ăn trưa tại Yên Minh, sau bữa trưa đoàn thăm quan:
    
    Phố Cáo, tìm hiểu nếp nhà còn giữ nguyên truyền thống, chụp ảnh hoa tam giác mạch hoa đào, hoa mơ, hoa mận …bên cạnh những  bờ  rào đá mắt cáo đặc sắc của người dân vùng cao ( nếu vào dịp hoa đào nở), tham quan và chụp ảnh thung lũng Sủng Là ( được gọi là thung lũng hoa hồng) nơi  từng là phim trường của bộ phim Chuyện Của PAO nổi tiếng.
    Làng văn hóa Lũng Cẩm (thuộc xã Sũng Là), men theo những hàng ngô xanh mướt dọc hai bên đường đoàn vào tham quan làng với những nét văn hoá đặc sắc của 3 dân tộc Lô Lô, Mông và Hán và những cánh đồng hoa rực rỡ sắc màu
    Dinh nhà Vương (Dinh Vua Mèo)– Đây là 1 công trình kiến trúc đẹp hiếm có và rất độc đáo của vùng cao nguyên núi đá. Sau đó đoàn tiếp tục khởi hành đi Lũng Cú. Quý khách có thể dừng chân chụp hình những dãy núi đá chập trùng hùng vỹ hay những cánh đồng hoa tam giác mạch rực rỡ sắc hồng khu vực Lũng Táo.
    chinh phục cột cờ Lũng Cú – Nơi địa đầu điểm Cực Bắc Tổ Quốc với lá cờ 54m2 tượng trưng cho 54 dân tộc anh em
    Xe đưa đoàn về Đồng Văn, nhận phòng khách sạn, nghỉ ngơi và ăn tối.
    <h3>Ngủ đêm tại khách sạn Đồng Văn</h3>
    <h2>Ngày 3 - ĐỒNG VĂN – MÃ PÍ LÈNG – NHO QUẾ – HÀ GIANG (Ăn sáng, trưa, chiều)</h2>
    Quý khách trả phòng, ăn sáng. Xe đưa Quý khách đi tham quan:
    
    Bức tranh sơn thủy hùng vĩ của một trong tứ đại đỉnh đèo vùng núi phía Bắc – Mã Pí Lèng nằm dọc theo dòng sông xanh Nho Quế chảy qua khe vực núi Tu Sản. Trên đường dừng chụp hình tại tượng đài Thanh Niên trước bảo tàng Con Đường Hạnh Phúc,  ngắm con đường hạnh phúc và toàn cảnh dòng sông Nho Quế từ trên cao.
    Chi phí Mã Pí Lèng Panorama café, chèo chuyền trên sông Nho Quế ngắm hẻm vực Tu Sản (chi phí tự túc)
    
    Sau khi ăn trưa, Quý khách khởi hành về Tp Hà Giang nhận phòng khách sạn, nghỉ ngơi.
    <h3>Nghỉ đêm tại khách sạn Hà Giang</h3>
    <h2>Ngày 4 - HÀ GIANG – HÀ NỘI (Ăn sáng, trưa)</h2>
    Quý khách trả phòng & ăn sáng, khởi hành về Hà Nội, trên đường dừng tham quan: 
    • Cao điểm 468, Vị Xuyên - thuộc thôn Nậm Ngặt xã Thanh Thủy, xuyên qua các con đường dốc chạy quanh vùng núi Đông Bắc cạnh cửa khẩu Thanh Thủy. Nơi đây là vị trí chiến lược quân sự, trở thành trận tuyến nóng bỏng, ác liệt kéo dài duy nhất trên toàn tuyến biên giới phía bắc để bảo vệ bình yên cho lãnh thổ hình chữ S.
    • Quý khách dừng nghỉ chân tại Trạm Dừng Pao 78 - Hà Giang mua sắm đặc sản miền núi Trà Shan Tuyết, mật ong Bạc Hà, trâu khô gác bếp, nấm Hương, măng khô.  
    Tiếp tục hành trình về lại Hà Nội, Quý khách dừng dùng cơm trưa tại Tuyên Quang. Chương trình du lịch kết thúc tại điểm đón ban đầu.
</pre>', 4390000, 10, 'on'),

('Điện Biên Phủ - Hoa dã quỳ vàng nở rực rỡ Tây Bắc', '2023-12-09', '2023-12-12', 'Hà Nội', '
<pre><h2>Ngày 1 - HÀ NỘI ĐIỆN BIÊN PHỦ - MÙA HOA BAN Số bữa ăn: 2 bữa (Trưa, tối)</h2>
    07h00, Xe ô tô và hướng dẫn viên của V Travel đón Quý khách tại Số 3 Hai Bà Trưng, Hoàn Kiếm, Hà Nội khởi hành ra sân bay Nội Bài, làm thủ tục cho quý khách đón chuyến bay đi Điện Biên.
    
    Thông tin chuyến bay dự kiến: VN8202 10:45 – 12:05.
    
    Đến sân bay Điện Biên Phủ, xe và hướng dẫn viên đón Quý khách đi ăn trưa tại nhà hàng địa phương.
    
    Quý khách tìm hiểu về những địa danh đã đi vào lịch sử của chiến trường Điện Biên Phủ “vang dội năm châu, chấn động địa cầu”.
    
    - Viếng Nghĩa trang liệt sỹ A1, đồi A1 - Nơi đây yên nghỉ của 644 cán bộ, chiến sĩ đã anh dũng chiến đấu và hy sinh trong chiến dịch Điện Biên Phủ.
    
    - Di tích Đồi A1, hầm Đờ Cát, cầu Mường Thanh, sông Nậm Rốm, Tượng đài Chiến thắng Điện Biên Phủ.
    
    - Ngắm con đường hoa ban trong trung tâm thành phố Điện Biên.
    
    17:00 Xe đưa Quý khách đi dùng cơm chiều và nhận phòng khách sạn nghỉ ngơi. Buổi tối Quý khách tự do tham quan.
    <h3>Nghỉ đêm tại thành phố Điện Biên Phủ</h3>
    <h2>Ngày 2 - CHIẾN TRƯỜNG XƯA ĐIỆN BIÊN PHỦ Số bữa ăn: 3 bữa (Sáng, trưa, tối)</h2>
    Quý khách dùng điểm tâm sáng tại khách sạn. 07h 30 xe và hướng dẫn viên đưa Quý khách đi tham quan:
    
    - Khu du lịch sinh thái Hồ Pá Khoang – Nàng tiên xanh: nơi đây có rừng nguyên sinh, hồ nước trong xanh là nguồn nước tưới tiêu dồi dào cho cánh đồng Mường Thanh màu mỡ. Pá Khoang theo cách gọi của người dân địa phương có nghĩa là rừng trúc. Thấp thoáng bên hồ là những bản làng người Thái, Mông, Khơ Mú sống xen kẽ, hòa mình vào với thiên nhiên, tạo nên một bức tranh đa màu sắc sinh động.
    
    - Đi xuồng máy quanh hồ, các đảo để trải nghiệm. Quý khách chụp những bức checkin làm kỷ niệm và thưởng thức khí hậu rất dễ chịu từ rừng nguyên sinh và làn gió mát mang theo hơi nước từ mặt hồ tỏa ra.
    
    - Sở chỉ huy chiến dịch Điện Biên Phủ - là nơi ở, làm việc của Đại tướng Võ Nguyên Giáp, tham mưu trưởng Hoàng Văn Thái và bộ chỉ huy chiến dịch năm xưa. Sở chỉ huy nằm ở độ cao trên 1.000m so với mặt biển, ẩn mình dưới tán rừng cổ thụ mà người dân địa phương coi đây là chốn “rừng thiêng”, là mảnh “vườn nhà” và thường gọi một cách trìu mến là “rừng Đại tướng”. Từ căn hầm chỉ huy đi ra triền núi phía sau, trèo lên đỉnh đồi Pú Cá, có thể quan sát toàn bộ thành phố Điện Biên Phủ, thung lũng Mường Thanh và các cứ điểm trước kia của quân Pháp như đồi Him Lam, đồi Độc Lập, đồi D1, đồi C1, đồi A1, cầu Mường Thanh...
    
    - Bảo tàng chiến thắng lịch sử Điện Biên Phủ - Bảo tàng trưng bày hơn 1.000 tư liệu hình ảnh, tài liệu, hiện vật, cảnh tượng lịch sử tái hiện lại cuộc chiến hào hùng của quân và dân ta trong Chiến dịch Điện Biên Phủ năm 1954 và Bức tranh panorama “Trận chiến Điện Biên Phủ” được đánh giá là Kỳ tích của nền Mỹ thuật Việt Nam.
    
    17:00 Quý khách về lại thành phố Điện Biên Phủ thưởng thức các món ăn mang đặc trưng hương vị Tây Bắc như: Thịt trâu gác bếp, cá suối nướng, măng đắng, gà nướng, canh bon…  
    <h3>Nghỉ đêm tại Điện Biên</h3>
    <h2>Ngày 3 - ĐIỆN BIÊN – HÀ NỘI Số bữa ăn: 2 bữa (Sáng, trưa)</h2>
    07h00, Dùng bữa sáng tại khách sạn.
    
    Quý khách trả phòng khách sạn, xe và hướng dẫn viên đưa Quý khách tham quan mua sắm đặc sản Tây Bắc về làm quà cho người thân và gia đình: gạo Điện Biên, mật ong, sâu chít, thịt trâu hun khói, chẳm chéo, măng, các sản phẩm mây tre đan, các sản phẩm thêu, dệt thổ cẩm,..
    
    Sau đó, xe đưa Quý khách ra sân bay đón chuyến bay đi thành phố hà Nội. Về đến sân bay Nội Bài, xe đưa quý khách về điểm tập trung ban đầu, kết thúc chương trình tham quan.
</pre>', 4690000, 5, 'on'),

('Ninh Bình - Bái Đính - Tràng An - Tuyệt Tình Cốc', '2023-12-20', '2023-12-22', 'Hà Nội', '
<pre><h2>Ngày 1 - HÀ NỘI – NINH BÌNH (Ăn Trưa, Tối)</h2>
    07:30: xe và HDV đón đoàn tại điểm hẹn: số 3 phố Hai Bà Trưng, Hoàn Kiếm, Hà Nội khởi hành đi Ninh Bình - vùng đất mệnh danh là “Nơi mơ đến, chốn mong về” với nhiều di tích văn hóa, thiên nhiên vô cùng đặc sắc. Đến nơi, Quý khách tham quan:
    •    Chùa Bái Đính với cổng Tam Quan được xây dựng với quy mô đồ sộ có ba tầng mái được lợp bằng ngói nam bát tràng, với hơn 500 bức tượng la hán được làm bằng đá xanh chạm khắc điêu luyện. Ngoài ra quý khách thăm điện Quan thế âm và điện Pháp trù được xây dựng hoàn toàn bằng gỗ tứ thiếp, Bảo Tháp cao 99m (chi phí tự túc)…. 
    •    Dùng cơm trưa tại nhà hàng địa phương. 
    •   Khu du lịch Tràng An: Quý khách lên thuyền truyền thống đi tham quan thắng cảnh hệ thống núi đá vôi hùng vĩ và các thung lũng ngập nước, thông với nhau bởi các dòng suối tạo nên các hang động ngập nước quanh năm. Điểm xuyến trong không gian hoang sơ, tĩnh lặng là hình ảnh rêu phong, cổ kính của các mái đình, đền, phủ nằm nép mình dưới chân các dãy núi cao.
    
    Đoàn dùng cơm tối và nhận phòng khách sạn nghỉ ngơi. Buổi tối quý khách tự do khám phá Phố cổ Hoa Lư, một không gian check-in cổ, đẹp, trầm mặc đẹp trở nên lung linh, huyền ảo hơn với sắc màu của những chiếc đèn lồng và Bảo Tháp trên Hồ Kỳ Lân; trải nghiệm nhiều hoạt động trò chơi dân gian và nhiều loại hình văn hóa nghệ thuật từ dân tộc như múa rối nước, nhảy múa Tắc Xình, hát xẩm, ... đến những buổi trình diễn acoustic sẽ được diễn ra vào các buổi tối ngày cuối tuần.
    <h3>Nghỉ đêm tại Khách sạn 4* Vissai Ninh Bình hoặc tương đương.</h3>
    <h2>Ngày 2 - NINH BÌNH - HÀ NỘI (Ăn Sáng, Trưa)</h2>
    Quý khách ăn sáng và trả phòng Khách sạn. Xe và HDV đưa quý khách đi tham quan:
    •    Tuyệt Tịnh Cốc: nằm giữa mảnh đất cố đô Hoa Lư (Ninh Bình), nơi đây có động Am Tiên ẩn mình giữa lưng chừng núi được mệnh danh là “thiên đường nơi hạ giới”, bao quanh động là vách núi đá vôi, tách biệt thế giới bên ngoài tạo nên vẻ đẹp nao lòng nơi thâm sơn cùng cốc, xứng đáng là “Tuyệt tịnh cốc” Ninh Bình; du khách đến đây ngoài “check-in” ảnh đẹp có thể đạp xe dạo mát quanh hồ thủy mặc (chi phí thuê xe tự túc). 
    
    Quý khách thưởng thức đặc sản dê Ninh Bình với các món như Nem dê, Dê tái chanh, Cơm cháy sốt dê, Dê nhúng mẻ ... 
    Xe và HDV của V Travel đưa quý khách khởi hành về Hà Nội. Đến điểm hẹn ban đầu, chia tay và hẹn gặp lại lần sau.
</pre>', 1990000, 6, 'on'),

('Sapa - Núi Hàm Rồng - Bản Cát Cát - Chinh phục Đỉnh Fansipan', '2023-12-12', '2023-12-15', 'Hà Nội', '
<pre><h2>Ngày 1 - HÀ NỘI – LÀO CAI - SAPA (Ăn trưa, tối)</h2>
    06h15 Xe và hướng dẫn viên đón đoàn tại Điểm hẹn - Vietravel Hanoi - Số 03 Phố Hai Bà Trưng, Hoàn Kiếm khởi hành đi Sapa.
    
    Trên đường đi quý khách tham quan:
    
    - Đền ông Hoàng Bảy - đền Bảo Hà: ngôi đền linh thiêng gắn với truyền thuyết về Ông Hoàng Bảy. Nơi đây đang dần trở thành một địa điểm du lịch tâm linh nổi tiếng nằm trên con đường đến với Sa Pa, Lào Cai. Nơi đây được rất nhiều người biết đến bởi sự linh thiêng kỳ lạ.
    
    Quý khách ăn trưa, tiếp tục di chuyển đến Sapa đến nơi quý khách nhận phòng nghỉ ngơi và tham quan:
    
    - Đỉnh đèo Ô Quy Hồ: một trong “Tứ đại đỉnh đèo” phía Bắc (không bao gồm vé tham quan Thác Bạc, Cầu Kính rồng mây, Cổng Trời...)
    
    - Núi Hàm Rồng: ngắm cảnh và chụp ảnh thị trấn Sapa trong sương, thăm vườn Lan 1-2 khoe sắc, vườn Lê, vườn Táo Mèo, Vườn hoa Trung Tâm, Hòn Đá Gãy, Cổng Trời, Đầu Rồng, Hòn Cá Sấu, Khu Thiên Thạch Lâm, Hòn Phật Bà, Sân Mây, Tháp truyền hình... 
    
    Ăn tối tại nhà hàng địa phương. 
    
    Quý khách tự do thăm quan:
    
    - Nhà Thờ Đá Sapa: dấu ấn kiến trúc của người Pháp còn lại vẹn toàn nhất tại Sa Pa, tự do thưởng thức đặc sản vùng cao như: thịt lợn cấp nách nướng, trứng nướng, rượu táo mèo, giao lưu với người dân tộc Mông, Dao.
    
    <h3>Nghỉ đêm tại Sapa</h3>
    <h2>Ngày 2 - SAPA – FANSIPAN HÙNG VĨ – BẢN CÁT CÁT (Ăn sáng, tối)</h2>
    Đoàn ăn sáng tại khách sạn sau đó:
    07:00 Xe và HDV đưa đoàn đến Sun PLaza, Quý khách trải nghiệm đến khu du lịch Fansipan Legend bằng Tàu hỏa leo núi Mường Hoa hiện đại nhất Việt Nam với tổng chiều dài gần 2000m, thưởng ngoạn bức tranh phong cảnh đầy màu sắc của cánh rừng nguyên sinh, thung lũng Mường Hoa.
    •    Chinh phục đỉnh núi Fansipan với độ cao 3.143m hùng vĩ bằng cáp treo (chi phí cáp treo  tự túc). 
    •    Lễ Phật tại chùa Trình hay cầu phúc lộc, bình an cho gia đình tại Bích Vân Thiền Tự trong hệ thống cảnh quan tâm linh trên đỉnh Fansipan. 
    Đoàn tự túc ăn trưa chiều tham quan:
    •    Bản Cát Cát - đường vào bản quanh co một bên là thung lũng Mường Hoa với những thửa ruộng bậc thang màu mỡ được tô điểm bởi màu xanh của ngô và lúa, thăm những nếp nhà của người Mông, Dao, Giáy… Quý khách còn có cơ hội thưởng thức những màn biểu diễn đặc sắc của các dân tộc nơi đây.
    Ăn tối tại nhà hàng. 
    Tự do tham quan Sapa về đêm, Quý khách có thể thưởng thức khoai nướng, trứng nướng – mang đậm tính đặc sắc vùng miền.
    
    <h3>Nghỉ đêm tại Sapa.</h3>
    <h2>Ngày 3 - SECRET GARDEN/MOANA - HÀ NỘI (Ăn sáng, trưa)</h2>
    Quý khách ăn sáng, trả phòng khách sạn sau đó tham quan:
    
    - Secret Garden/Moana: điểm sống ảo mới toanh giữa lòng phố núi Sapa đang làm mưa làm gió với ‘giường trên không’ và ‘nhà bong bóng’. Hãy nghĩ đến cảnh bạn sẽ được nằm ườn trên chăn bông bồng bềnh, view ‘khách sạn ngàn sao’, có thể nằm ngắm trời ngắm mây, nhìn thẳng ra những dãy núi mờ ảo trong mây.
    
    Đoàn ăn trưa tại nhà hàng. Quý khách lên xe trở về Hà Nội.
    
    Về đến Hà Nội, chia tay Quý khách. Kết thúc chương trình.
    </pre>', 2990000, 3, 'on'),

('Tây Bắc: Hà Nội - Nghĩa Lộ - Tú Lệ - Mù Cang Chải - Sapa - Fansipan - Lai Châu - Điện Biên - Sơn La - Mộc Châu
Island', '2023-12-02', '2023-12-08', 'Hà Nội', '
<pre><h2>Ngày 1 - HÀ NỘI - YÊN BÁI - NGHĨA LỘ 02 bữa ăn: (Trưa, Tối)</h2>
    Quý khách có mặt tại điểm hẹn tại trung tâm Hà Nội, đoàn khởi hành đi Yên Bái. Trên đường đi đoàn tham quan: 
    - Đền Hùng: nơi thờ các vua Hùng có công dựng nước, tổ tiên của dân tộc Việt Nam, một quần thể kiến trúc thâm nghiêm trên núi Nghĩa Lĩnh. Đoàn dâng hương đất tổ, thăm quan đền Thượng, đền Trung, đền Hạ, Giếng Ngọc, Lăng vua Hùng.
    - Buổi tối, thưởng thức chương trình biểu diễn múa Xòe, giao lưu và tìm hiểu nét văn hóa đặc sắc của dân tộc Thái. 
    <h3>Nghỉ đêm tại Nghĩa Lộ.</h3>
    <h2>Ngày 2 - NGHĨA LỘ - MÙ CANG CHẢI - SAPA 03 bữa ăn: (Sáng, Trưa, Tối)</h2>
    Trả phòng khách sạn, đoàn khởi hành đi Mù Cang Chải, ngang qua: 
    - Tú Lệ, Quý khách sẽ ngửi được mùi hương thoang thoảng theo gió bảng lảng trên mái nhà của “cơm mới”, nơi đây nổi tiếng với xôi nếp, cốm khô. 
    - Đèo Khau Phạ: đèo hiểm trở và dài nhất trên tuyến quốc lộ 32 được mệnh danh là một trong “tứ đại đèo” với độ dài trên 30km.
    - Bản Lìm Mông: đây là Bản của dân tộc Mông và là nơi có ruộng lúa đẹp nhất Mù Cang Chải. Quý khách sẽ bị mê hoặc bởi vẻ đẹp hút hồn của cung đường ruộng bậc thang nổi tiếng tại 3 xã: La Pán Tẩn, Chế Cu Nha và Zế Xu Phình. Đoàn chiêm ngưỡng những thung lũng rộng hút tầm mắt, các thửa ruộng tầng tầng lớp lớp lượn sóng theo sườn núi, ngọn núi này nối tiếp ngọn núi khác.
    Buổi tối Quý khách dạo phố, ngắm nhà thờ Đá Sapa, tự do thưởng thức đặc sản vùng cao như: thịt lợn cắp nách nướng, trứng nướng, rượu táo mèo, giao lưu với người dân tộc vùng cao. 
    <h3>Nghỉ đêm tại Sa Pa.</h3>
    <h2>Ngày 3 - SAPA - LAI CHÂU 03 bữa ăn:(Sáng, Trưa, Tối)</h2>
    Trả phòng khách sạn, xe đưa đoàn ra ga Sapa, Quý khách trải nghiệm đến khu du lịch Fansipan Legend bằng Tàu hỏa leo núi Mường Hoa hiện đại nhất Việt Nam với tổng chiều dài gần 2000m, thưởng ngoạn bức tranh phong cảnh đầy màu sắc của cánh rừng nguyên sinh, thung lũng Mường Hoa.
    - Chinh phục đỉnh núi Fansipan với độ cao 3.143m hùng vĩ bằng cáp treo (chi phí tự túc). 
    - Lễ Phật tại chùa Trình hay cầu phúc lộc, bình an cho gia đình tại Bích Vân Thiền Tự trong hệ thống cảnh quan tâm linh trên đỉnh Fansipan. 
    Sau đó xe khởi hành đi Lai Châu, trên đường ghé tham quan:
    - Chinh phục đèo Ô Quy Hồ - con đèo đẹp, hùng vĩ và dài nhất trong Tứ Đại Đỉnh Đèo miền Bắc.
    - Khu du lịch Cổng Trời Ô Quy Hồ - một trong những điểm săn mây, ngắm hoàng hôn cực đẹp tại Sapa.
    Đến nơi, Quý khách dùng cơm tối và nhận phòng khách sạn nghỉ ngơi.
    <h3>Nghỉ đêm tại Lai Châu.</h3><h3>Lưu ý: Trong trường hợp, Fansipan không hoạt động chương trình sẽ được thay thế bằng điểm tham quan Cầu Kính Rồng Mây (không bao gồm vé tham quan).</h3>
    <h2>Ngày 4 - LAI CHÂU - ĐIỆN BIÊN 03 bữa ăn: (Sáng, Trưa, Tối)</h2>
    Đoàn khởi hành đi Điện Biên:
    
    - Trên đường ngắm cảnh rừng núi Tây Bắc dọc theo dòng sông Nậm Na và vùng ngập nước do đập nhà máy Thủy điện Sơn La dâng lên tại ngã ba sông: sông Đà, sông Nậm Na và sông Nậm Rốm. 
    
    - Di tích Đồi A1, hầm Đờ Cát, cầu Mường Thanh, sông Nậm Rốm, Tượng đài Chiến thắng Điện Biên Phủ
    
    - Đền thờ liệt sĩ tại Chiến trường Điện Biên Phủ công trình kiến trúc độc đáo với không gian tưởng niệm tại sân tĩnh tâm và hồ tưởng niệm được tạo hình bởi các vòng tròn đồng tâm, tạo sự tập trung, tĩnh tâm trước khi đến với không gian tâm linh.
    <h3>Nghỉ đêm tại Điện Biên</h3>
    <h2>Ngày 5 - ĐIỆN BIÊN - SƠN LA - MỘC CHÂU – RỪNG THÔNG BẢN ÁNG 03 bữa ăn: (Sáng, Trưa, Chiều)</h2>
    Đoàn khởi hành đi Mộc Châu - Sơn La, tham quan: 
    - Đèo Pha Đin: đây cũng là một trong ""tứ đại đèo"" vùng Đông Tây Bắc và được xếp cùng nhóm 6 con đèo gây ấn tượng nhất Việt Nam. 
    - Rừng thông Bản Áng: Được bao phủ bởi rừng thông cổ thụ hàng trăm năm tuổi với không khí trong lành, mát mẻ. Với diện tích gần 50ha với đầy đủ các dịch vụ: nghỉ dưỡng, nhà hàng, sân tập golf, khu vui chơi cảm giác mạnh, ... là một trong những điểm tham quan đặc sắc thu hút nhiều sự quan tâm của du khách. 
    Quý khách dùng cơm chiều tại nhà hàng địa phương và nhận phòng khách sạn nghỉ ngơi hoặc tự do tham quan. 
    <h3>Nghỉ đêm tại Mộc Châu.</h3> 
    <h2>Ngày 6 - MỘC CHÂU ISLAND - HÀ NỘI 02 bữa ăn: (Sáng, Trưa)</h2>
    Ăn sáng và trả phòng khách sạn. Xe đưa Quý khách tham quan: 
    -    Quần thể phức hợp vui chơi giải trí và nghỉ dưỡng Mộc Châu Island chiêm ngưỡng vẻ đẹp Cầu kính Bạch Long có chiều dài 632m, ở độ cao cách mặt đất 150m, là “Cây cầu kính đi bộ dài nhất thế giới” vừa được xác lập kỷ lục Guinness vào tháng 28/5/2022. Trải nghiệm các trò chơi (chi phí tự túc): Chinh phục cầu kính Bạch Long, trượt Airslide, zipline, …
    - Mua sắm đặc sản nổi tiếng được chế biến từ sữa bò tươi nổi tiếng của Mộc Châu về làm quà. 
    - Dừng chụp hình đèo Thung Khe hay còn gọi là đèo Đá Trắng, nơi đây quanh năm trắng như tuyết và mây mù bao phủ tạo cảnh quan tuyệt đep thu hút nhiều du khách đến chụp ảnh.
    Tiếp tục hành trình về Hà Nội. Chia tay Quý khách và kết thúc chương trình du lịch tại điểm hẹn ban đầu.
</pre>', 7300000, 2, 'on'),

('Hà Nội - Đồi Chè Long Cốc - Bắc Yên - Sống lưng khủng long Tà Xùa - Mộc Châu', '2023-12-03', '2023-12-07', 'Đà Nẵng',
'
<pre><h2>Ngày 1 - SB Nội Bài – Hà Nội (tự túc ăn ngày đầu tiên)</h2>
    Quý khách tập trung tại sân bay Đà Nẵng (ga trong nước), tự túc làm thủ tục cho Quý khách đáp chuyến bay đi Hà Nội. Đến sân bay Nội Bài, xe đưa quý khách về trung tâm Hà Nội nhận phòng khách sạn nghỉ ngơi. 
    <h3>Nghỉ đêm tại Hà Nội.</h3>
    <h2>Ngày 2 - Hà Nội - Xuân Sơn - Bắc Yên 03 bữa ăn (Sáng, Trưa, Chiều)</h2>
    Ăn sáng và trả phòng khách sạn. Xe khởi hành đưa Quý khách đi tham quan: 
    - Ngắm Hồ Hoàn Kiếm chụp hình bên ngoài Tháp Rùa, Đền Ngọc Sơn, Cầu Thê Húc.
    - Khu Di tích lịch sử Đền Hùng tham quan, dâng hương tưởng niệm các vua Hùng, tìm hiểu về những câu chuyện truyền thuyết thời kỳ Hùng Vương dựng nước và giữ nước, tìm hiểu về tín ngưỡng thờ cúng Hùng Vương - di sản văn hoá phi vật thể của nhân loại được Unessco công nhận năm 2012 - tri ân công đức tổ tiên, các bậc tiền nhân có công dựng nước, giữ nước, cầu mong cuộc sống bình an.
    - Dùng cơm trưa tại nhà hàng địa phương và chụp hình lưu niệm Đồi Chè Long Cốc “Tuyệt tác thiên nhiên vùng Trung Du” Tại đây quý khách được hòa mình vào thiên nhiên trong lành với những đồi Chè mâm xôi xanh ngát trùng điệp được đánh giá đồi Chè đẹp nhất Việt Nam. 
    Tiếp tục hành trình đến thị trấn Bắc Yên, Quý khách nhận phòng khách sạn và dùng cơm tối tại nhà hàng địa phương. Buổi tối, Quý khách nghỉ sớm để chuẩn bị hành trình đón bình minh trên Tà Xùa. 
    <h3>Nghỉ đêm tại Bắc Yên.</h3> 
    <h2>Ngày 3 - Bắc Yên – Sống lưng khủng long Tà Xùa – Rừng Thông Bản Áng – Mộc Châu 03 bữa ăn (Sáng, Trưa, Chiều)</h2>
    05:00 sáng, Quý khách bắt đầu hành trình đi săn mây và đón bình minh tại Tà Xùa. 
    (Lưu ý: Quý khách vui lòng khởi hành đúng giờ):
    
    - Check in “Sống lưng khủng long”: một trong những điểm check-in thần thánh của giới trẻ thời gian gần đây. Nằm ở độ cao 1500 - 1800m so với mực nước biển, “Sống lưng khủng long” trở nên vô cùng huyền ảo khi có những tầng mây trắng đổ dài trước mắt, cùng những giọi nắng vàng trong buổi sáng tinh mơ sẽ làm lây động tâm hồn của người yêu xê dịch.
    
    - Quý khách dừng nghỉ ngơi nhâm nhi tách cà phê tại Thào Coffee (chi phí tự túc) – quán cà phê với view ngắm nhìn toàn cảnh nổi tiếng tại Tà Xùa. 
    
    Xe đưa Quý khách về khách sạn trả phòng và dùng cơm trưa. Khởi hành đi Mộc Châu. Đến nơi, Quý khách dùng cơm tối và tham quan Rừng Thông Bản Áng về đêm – nơi đây được bao phủ bởi rừng thông cổ thụ hàng trăm năm tuổi với không khí trong lành, mát mẻ. Với diện tích gần 50ha với đầy đủ các dịch vụ: nghỉ dưỡng, nhà hàng, sân tập golf, khu vui chơi cảm giác mạnh, ... là một trong những điểm tham quan đặc sắc thu hút nhiều sự quan tâm của du khách.
    
    Quý khách nhận phòng khách sạn nghỉ ngơi hoặc tự do tham quan. 
    <h3>Nghỉ đêm tại Mộc Châu.</h3>
    <h2>Ngày 4 - Kỷ lục GUINESS mới – Cầu Kính Bạch Long, Mộc Châu Island – SB Nội Bài 02 bữa ăn (Sáng, Trưa)</h2>
    Quý khách ăn sáng tại khách sạn và trả phòng. Trước khi chào tạm biệt núi rừng Tây Bắc, xe đưa Quý khách đi tham quan: 

    - Quần thể phức hợp vui chơi giải trí và nghỉ dưỡng Mộc Châu Island bao gồm xe điện đi tham quan nhà hàng tre Tabamboo lớn nhất Việt Nam, khách sạn Đoàn Tàu “bullet Train”, hệ thống thủy điện, tham gia các trò chơi đu Zipline, trượt cầu vòng Airslide, khu vui chơi trẻ em ngoài trời,… 

    - Chiêm ngưỡng vẻ đẹp Cầu kính Bạch Long (chi phí tự túc) có chiều dài 632m, ở độ cao cách mặt đất 150m, là “Cây cầu kính đi bộ dài nhất thế giới” vừa được xác lập kỉ lục Guinness vào tháng 28/5/2022. Nối tiếp cuối chân cầu kính là hang Chim Thần với các nhũ đá tự nhiên và các công trinh điêu khắc trên đá của người Thái xưa. Quý khách thưởng thức bữa trưa tại nhà hàng tre lớn nhất Việt Nam. 

    - Mua sắm đặc sản nổi tiếng được chế biến từ sữa bò tươi nổi tiếng của Mộc Châu về làm quà. 

    - Dừng chụp hình đèo Thung Khe hay còn gọi là đèo Đá Trắng, nơi đây quanh năm trắng như tuyết và mây mù bao phủ tạo cảnh quan tuyệt đep thu hút nhiều du khách đến chụp ảnh.

    Tiếp tục hành trình đến sân bay Nội Bài, Hướng dẫn viên hỗ trợ Quý khách làm thủ tục đáp chuyến bay về Tp.Đà Nẵng. Chia tay Quý khách và kết thúc chương trình du lịch.
</pre>', 6990000, 7, 'on'),

('Hà Nội - Bái Đính - Khu Du Lịch Tràng An - Bái Đính - Hạ Long - Yên Tử', '2023-12-14', '2023-12-18', 'Đà Nẵng', '
<pre><h2>Ngày 1 - Đà Nẵng - Nội Bài (Hà Nội) – Hà Nội (Ăn trưa, tối)</h2>
    Quý khách tập trung tại Sân bay Đà Nẵng, Ga đi Trong Nước. Hướng dẫn viên làm thủ tục cho Quý khách đáp chuyến bay đi Hà Nội. Quý khách ăn trưa tại nhà hàng địa phương và tham quan những di tích văn hóa nổi tiếng tại thủ đô: 
    
    Một vòng Hồ Hoàn Kiếm ngắm bên ngoài Tháp Rùa, Đền Ngọc Sơn, Cầu Thê Húc.
    Văn Miếu: nơi thờ Khổng Tử và các bậc hiền triết của Nho Giáo, Quốc Tử Giám - trường đại học đầu tiên của Việt Nam, tìm về cội nguồn lịch sử của các vị Nho học.
    Quý khách dùng cơm chiều và nhận phòng khách sạn nghỉ ngơi. Buổi tối, Quý khách tự do khám phá 36 phố phường Hà Nội. 
    <h3>Nghỉ đêm tại Hà Nội</h3>
    <h2>Ngày 2 - Hà Nội – Ninh Bình – Tràng An – Bái Đính (Ăn 3 bữa)</h2>
    Ăn sáng và trả phòng khách sạn. Xe khởi hành đưa Quý khách tham quan cụm Lăng Hồ Chủ Tịch (không viếng lăng vào thứ 2, thứ 6 hàng tuần và giai đoạn bảo trì định kỳ hàng năm 15/6 – 15/8) tham quan và tìm hiểu cuộc đời và sự nghiệp của vị cha già dân tộc tại Nhà Sàn Bác Hồ, Bảo Tàng Hồ Chí Minh, Chùa Một Cột.
    
    Tiếp tục hành trình, Quý khách đến với Ninh Bình - vùng đất mệnh danh là “Nơi mơ đến, chốn mong về” với nhiều di tích văn hóa, thiên nhiên vô cùng đặc sắc. Đến nơi, Quý khách tham quan: 
    
    Chùa Bái Đính - một quần thể chùa với nhiều kỷ lục Việt Nam như pho tượng phật Di Lặc bằng đồng nặng 80 tấn, hành lang với 500 tượng vị La Hán, tòa Bảo Tháp cao 99m…
    Khu Du lịch Tràng An - Quý khách lên thuyền truyền thống đi tham quan thắng cảnh hệ thống núi đá vôi hùng vĩ và các thung lũng ngập nước, thông với nhau bởi các dòng suối tạo nên các hang động ngập nước quanh năm. Điểm xuyến trong không gian hoang sơ, tĩnh lặng là hình ảnh rêu phong, cổ kính của các mái đình, đền, phủ nằm nép mình dưới chân các dãy núi cao. 
    Quý khách dùng cơm tối và nhận phòng khách sạn nghỉ ngơi. Buổi tối quý khách tự do khám phá Phố cổ Hoa Lư, một không gian check-in cổ, đẹp, trầm mặc đẹp trở nên lung linh, huyền ảo hơn với sắc màu của những chiếc đèn lồng và Bảo Tháp trên Hồ Kỳ Lân; trải nghiệm nhiều hoạt động trò chơi dân gian và nhiều loại hình văn hóa nghệ thuật từ dân tộc như múa rối nước, nhảy múa Tắc Xình, hát xẩm, ... đến những buổi trình diễn acoustic sẽ được diễn ra vào các buổi tối ngày cuối tuần.
    <h3>Nghỉ đêm tại Ninh Bình</h3>
    <h2>Ngày 3 - Hạ Long – Động Thiên Cung (Ăn 3 bữa)</h2>
    Quý khách ăn sáng và trả phòng khách sạn. Xe khởi hành đưa Quý khách đến thành phố biển Hạ Long tham quan:
    
    Xuống thuyền đi du ngoạn Vịnh Hạ Long - Thắng cảnh thiên nhiên tuyệt đẹp và vô cùng sống động, được UNESCO công nhận là di sản thiên nhiên Thế giới năm 1994.
    Từ trên tàu ngắm nhìn các hòn đảo lớn nhỏ trong Vịnh Hạ Long: Hòn Gà Chọi, Hòn Lư Hương.
    Động Thiên Cung là một trong những động đẹp nhất ở Hạ Long. Vẻ đẹp nguy nga và lộng lẫy bởi những lớp thạch nhũ và những luồng ánh sáng lung linh.
    Xe đón Quý khách tại bến tàu và khởi hành đi tham quan chụp hình bên ngoài Bảo tàng Quảng Ninh, Cung Cá Heo - Cung Quy Hoạch, Hội Chợ, Triển Lãm Và Văn Hóa Quảng Ninh, tham quan mua sắm đặc sản tại Hải Sản Hương Đà Hạ Long với nhiều mặt hàng hải sản tươi, khô, chả mực,.. 
    
    Quý khách dùng cơm chiều và nhận phòng khách sạn nghỉ ngơi. Buổi tối, Quý khách tự do khám phá nhiều hoạt động dịch vụ giải trí sôi nổi tại “phố cổ” Bãi Cháy - nằm cạnh công viên Sun World Hạ Long từ những ẩm thực đường phố đến các quán cà phê siêu dễ thương như Hòn Gai Coffee & Lounge hay thoải mái bung xõa tại The Mini Bar, Brothers Pub,…
    <h3>Nghỉ đêm tại Hạ Long</h3>
    Hoặc lựa chọn một số dịch vụ khám phá Hạ Long về đêm (tự túc phương tiện và chi phí tham quan):
    
    -    Trải nghiệm dịch vụ Cáp Treo Nữ Hoàng tại Sun World Hạ Long Complex trên Núi Ba Đèo, chiêm ngưỡng cảnh đẹp về đêm của thành phố Hạ Long dưới ánh đèn lung linh (thời gian hoạt động cáp treo dự kiến từ 10h đến 18h các ngày thứ 7 và CN).
    <h2>Ngày 4 - Hạ Long – Sân Bay Nội Bài – Đà Nẵng (Ăn sáng, trưa)</h2>
    Quý khách ăn sáng và trả phòng khách sạn. Xe đưa Quý khách đi tham quan:
    
    Vùng đất thiêng Yên Tử: Quý khách lên cáp treo du ngoạn thắng cảnh thiên nhiên Đông Yên Tử (chi phí cáp treo tự túc), nơi còn lưu giữ nhiều di tích lịch sử mệnh danh “Đất tổ Phật giáo Việt Nam”, chiêm bái chùa Một Mái, chùa Hoa Yên – nơi tu hành của phật hoàng Trần Nhân Tông khai sinh ra dòng mới Thiền Phái Trúc Lâm, nằm trên lưng chừng núi ở độ cao 516m. Theo dấu chân Phật Hoàng viếng Chùa Đồng có tên Thiên Trúc Tự (chùa Cõi Phật), tọa lạc ở đỉnh cao nhất dãy Yên Tử (1.068m) – ngôi chùa bằng đồng lớn nhất Việt Nam.
    Dừng tại trạm dừng chân Hải Dương mua đặc sản: bánh đậu xanh, bánh khảo
    Xe khởi hành đưa Quý khách ra sân bay Nội Bài làm thủ tục đón chuyến bay về Tp.Đà Nẵng. Chia tay Quý khách và kết thúc chương trình du lịch tại sân bay Đà Nẵng. 
</pre>', 6990000, 4, 'on'),

('Hà Nội - Vịnh Hạ Long - Chùa Bái Đính - Tràng An - Tuyệt Tịnh Cốc', '2023-12-07', '2023-12-11', 'TP. Hồ Chí Minh', '
<pre><h2>Ngày 1 - SB NỘI BÀI – HÀ NỘI 02 bữa ăn: (Trưa, Chiều)</h2>
    Quý khách tập trung tại sân bay Tân Sơn Nhất (Ga nội địa), hướng dẫn viên hỗ trợ khách làm thủ tục đáp chuyến bay đi Hà Nội. Đến sân bay Nội Bài, xe và HDV của V Travel đón Quý khách đi Hà Nội. Xe đưa Quý khách đi tham quan:
        
        Hoàng thành Thăng Long: quần thể công trình kiến trúc đồ sộ được các triều vua xây dựng trong nhiều giai đoạn lịch sử và trở thành di tích quan trọng bậc nhất trong hệ thống các di tích Việt Nam.
        
        Văn Miếu: nơi thờ Khổng Tử và các bậc hiền triết của Nho Giáo, Quốc Tử Giám - trường đại học đầu tiên của Việt Nam, tìm về cội nguồn lịch sử của các vị Nho học.
    
    Quý khách nhận phòng khách sạn nghỉ ngơi hoặc tự do dạo 36 phố phường Hà Nội, trải nghiệm không gian sôi nổi, náo nhiệt tại Phố Tạ Hiện hay tìm một gốc với ly cà phê quan sát phố cổ hẳn cũng rất thú vị.
    <h3>Nghỉ đêm tại Hà Nội.</h3>  
    <h2>Ngày 2 - HÀ NỘI – HẠ LONG 03 bữa ăn: (Sáng, Trưa, Chiều)</h2>
    Quý khách ăn sáng và trả phòng khách sạn.  Xe khởi hành đưa Quý khách đi tham quan Hồ Hoàn Kiếm ngắm bên ngoài Tháp Rùa, Đền Ngọc Sơn, Cầu Thê Húc.

    Tiếp tục hành trình, xe khởi hành đưa Quý khách đến thành phố biển Hạ Long qua đường cao tốc Hải Phòng – Hạ Long, trên đường ngắm cảnh Bạch Đằng Giang. Đến nơi, Quý khách xuống thuyền đi du ngoạn Vịnh Hạ Long - Thắng cảnh thiên nhiên tuyệt đẹp và vô cùng sống động, được UNESCO công nhận là di sản thiên nhiên Thế giới năm 1994.

        Động Thiên Cung là một trong những động đẹp nhất ở Hạ Long. Vẻ đẹp nguy nga và lộng lẫy bởi những lớp thạch nhũ và những luồng ánh sáng lung linh.
    
        Từ trên tàu ngắm nhìn các hòn đảo lớn nhỏ trong Vịnh Hạ Long: Hòn Gà Chọi, Hòn Lư Hương.
    
        Tham quan mua sắm đặc sản tại Trung Tâm OCOP Central Hạ Long với nhiều mặt hàng hải sản tươi, khô, chả mực, … đạt chất lượng theo tiêu chuẩn OCOP.
    
    Quý khách nhận phòng khách sạn nghỉ ngơi hay tự do khám phá nhiều hoạt động dịch vụ giải trí sôi nổi tại “phố cổ” Bãi Cháy - nằm cạnh công viên Sun World Hạ Long từ những ẩm thực đường phố đến các quán cà phê siêu dễ thương như Hòn Gai Coffee & Lounge hay thoải mái bung xõa tại The Mini Bar, Brothers Pub,..
     
    Hoặc lựa chọn một số dịch vụ khám phá Hạ Long về đêm (tự túc phương tiện và chi phí tham quan):

        Trải nghiệm dịch vụ Cáp Treo Nữ Hoàng tại Sun World Hạ Long Complex trên Núi Ba Đèo, chiêm ngưỡng cảnh đẹp về đêm của thành phố Hạ Long dưới ánh đèn lung linh (thời gian hoạt động cáp treo dự kiến từ 10h đến 18h các ngày thứ 7 và CN)
    <h3>Nghỉ đêm tại Hạ Long.</h3>
    <h2>Ngày 3 - HẠ LONG – NINH BÌNH 03 bữa ăn: (Sáng, Trưa, Chiều)</h2>
    Quý khách ăn sáng tại khách sạn. Xe đưa Quý khách đi tham quan Bảo Tàng Quảng Ninh và chụp hình bên ngoài Cung Cá Heo - Cung Quy Hoạch, Hội Chợ, Triển Lãm Và Văn Hóa Quảng Ninh, dường như đã trở thành điểm đến ấn tượng trong du khách với lối kiến trúc độc đáo.
    
    Quý khách về khách sạn trả phòng và dùng cơm trưa. Tiếp tục hành trình, Quý khách khởi hành đi Ninh Bình - vùng đất mệnh danh là “Nơi mơ đến, chốn mong về” với nhiều di tích văn hóa, thiên nhiên vô cùng đặc sắc. Đến nơi, quý khách chiêm bái Chùa Bái Đính - một quần thể chùa với nhiều kỷ lục Việt Nam như pho tượng phật Di Lặc bằng đồng nặng 80 tấn, hành lang với 500 tượng vị La Hán, tòa Bảo Tháp cao 99m…
    
    Quý khách tự do khám phá Phố cổ Hoa Lư, một không gian check-in cổ, đẹp, trầm mặc đẹp trở nên lung linh, huyền ảo hơn với sắc màu của những chiếc đèn lồng và Bảo Tháp trên Hồ Kỳ Lân; trải nghiệm nhiều hoạt động trò chơi dân gian và nhiều loại hình văn hóa nghệ thuật từ dân tộc như múa rối nước, nhảy múa Tắc Xình, hát xẩm,.. đến những buổi trình diễn acoustic sẽ được diễn ra vào các buổi tối ngày cuối tuần.
    <h3>Nghỉ đêm tại Ninh Bình.</h3>
    <h2>Ngày 4 - NINH BÌNH – SB NỘI BÀI 02 Bữa ăn: (Sáng, Trưa)</h2>
    Quý khách ăn sáng và trả phòng khách sạn. Xe đưa Quý khách đi tham quan:
    
        Khu Du Lịch Tràng An: Quý khách lên thuyền truyền thống đi tham quan thắng cảnh hệ thống núi đá vôi hùng vĩ và các thung lũng ngập nước, thông với nhau bởi các dòng suối tạo nên các hang động ngập nước quanh năm. Điểm xuyến trong không gian hoang sơ, tĩnh lặng là hình ảnh rêu phong, cổ kính của các mái đình, đền, phủ nằm nép mình dưới chân các dãy núi cao.
        
        Tuyệt Tịnh Cốc: nằm giữa mảnh đất cố đô Hoa Lư (Ninh Bình), động Am Tiên ẩn mình giữa lưng chừng núi được mệnh danh là “thiên đường nơi hạ giới” và được giới trẻ gọi là Tuyệt Tịnh Cốc Việt Nam.                           
    
    Xe khởi hành đưa Quý khách ra sân bay Nội Bài làm thủ tục đón chuyến bay về Tp.HCM. Chia tay Quý khách và kết thúc chương trình du lịch tại sân bay Tân Sơn Nhất. 
</pre>', 8390000, 5, 'on'),

('Liên Tuyến Bắc Trung: Hà Nội - Sapa - Fansipan - Hạ Long - Ninh Bình - Đà Nẵng - Sơn Trà - KDL Bà Nà - Cầu Vàng - Hội
An - La Vang - Huế - Động Phong Nha & Thiên Đường - Đà Nẵng', '2023-12-02', '2023-12-14', 'TP. Hồ Chí Minh', '
<pre><h2>Ngày 1 - TP.HCM – SB NỘI BÀI – HÀ NỘI: (Tự túc ăn ngày đầu tiên)</h2>
    Quý khách tập trung tại sân bay Tân Sơn Nhất (ga trong nước), hướng dẫn làm thủ tục cho Quý khách đáp chuyến bay đi Hà Nội. Đến sân bay Nội Bài, xe đưa quý khách về trung tâm Hà Nội nhận phòng khách sạn nghỉ ngơi. 
    <h3>Nghỉ đêm tại Hà Nội.</h3>   
    <h2>Ngày 2 - HÀ NỘI – SAPA 03 bữa ăn: (Sáng, Trưa, Chiều)</h2>
    Quý khách ăn sáng và trả phòng.  Xe khởi hành theo cao tốc Hà Nội – Lào Cai đưa Quý khách đến phố núi Sapa. Trên đường, Quý khách dùng cơm trưa tại nhà hàng địa phương. Đến nơi, Quý khách tham quan: 
    
    - Bản Cát Cát - đẹp như một bức tranh giữa vùng phố cổ Sapa, nơi đây thu hút du khách bởi cầu treo, thác nước, guồng nước và những mảng màu hoa mê hoặc du khách khi lạc bước đến đây. Thăm những nếp nhà của người Mông, Dao, Giáy trong bản, du khách sẽ không khỏi ngỡ ngàng trước vẻ đẹp mộng mị của một trong những ngôi làng cổ đẹp nhất Sapa.
    
    Quý khách dùng cơm tối và nhận phòng nghỉ ngơi hoặc tự do dạo phố ngắm nhà thờ Đá Sapa, tự do thưởng thức đặc sản vùng cao như: thịt lợn cắp nách nướng, trứng nướng, rượu táo mèo, giao lưu với người dân tộc vùng cao.
    <h3>Nghỉ đêm tại Sapa.</h3>
    <h2>Ngày 3 - SAPA – FANSIPAN LEGEND – ĐÈO Ô QUY HỒ 03 bữa ăn: (Sáng, Trưa, Chiều)</h2>
    Quý khách dùng điểm tâm sáng tại khách sạn. xe đưa đoàn ra ga Sapa, Quý khách trải nghiệm đến khu du lịch Fansipan Legend bằng Tàu hỏa leo núi Mường Hoa hiện đại nhất Việt Nam với tổng chiều dài gần 2000m, thưởng ngoạn bức tranh phong cảnh đầy màu sắc của cánh rừng nguyên sinh, thung lũng Mường Hoa.
    
    - Chinh phục đỉnh núi Fansipan với độ cao 3.143m hùng vĩ bằng cáp treo (chi phí tự túc). 
    - Lễ Phật tại chùa Trình hay cầu phúc lộc, bình an cho gia đình tại Bích Vân Thiền Tự trong hệ thống cảnh quan tâm linh trên đỉnh Fansipan.  
     
    Tiếp tục hành trình, Quý khách dùng cơm trưa và tham quan: 
    - Chinh phục đèo Ô Quy Hồ - con đèo đẹp, hùng vĩ và dài nhất trong Tứ Đại Đỉnh Đèo miền Bắc.
    - Khu du lịch Cổng Trời Ô Quy Hồ - một trong những điểm săn mây, ngắm hoàng hôn cực đẹp tại Sapa.
    
    Quý khách dùng cơm tối tại Sapa và tự do nghỉ ngơi.
    <h3>Nghỉ đêm tại Sapa.</h3>
    Lưu ý: Trong trường hợp, Fansipan không hoạt động chương trình sẽ được thay thế bằng điểm tham quan Cầu Kính Rồng Mây (không bao gồm vé tham quan).  
    <h2>Ngày 4 - SAPA – LÀO CAI – HÀ NỘI 03 bữa ăn: (Sáng, Trưa, Chiều)</h2>
    Quý khách ăn sáng và trả phòng khách sạn. Xe khởi hành đưa Quý khách về Hà Nội, trên đường dừng tham quan mua sắm tại Siêu thị Du lịch nông nghiệp Ocop Phú Thọ - chợ Tp Việt Trì và dùng cơm trưa tại nhà hàng địa phương.  Đến Hà Nội nhận phòng khách sạn nghỉ ngơi hoặc tự do đi tham quan Hồ Hoàn Kiếm ngắm bên ngoài Tháp Rùa, Đền Ngọc Sơn, Cầu Thê Húc.
    <h3>Nghỉ đêm tại Hà Nội.</h3> 
    <h2>Ngày 5 - HÀ NỘI – HẠ LONG 03 Bữa ăn: (Sáng, Trưa, Chiều)</h2>
    Quý khách ăn sáng và trả phòng. Xe khởi hành đưa Quý khách đi tham quan:
    
    - Lăng Hồ Chủ Tịch (không viếng vào thứ 2, thứ 6 hàng tuần và giai đoạn bảo trì định kì hàng năm 15/6 – 15/8) tham quan và tìm hiểu cuộc đời và sự nghiệp của vị cha già dân tộc tại Nhà Sàn Bác Hồ, Bảo Tàng Hồ Chí Minh, Chùa Một Cột.
    
    Tiếp tục hành trình, xe đưa Quý Khách đi Hạ Long, trên đường tham quan Danh thắng Yên Tử:
    - Quý khách lên cáp treo du ngoạn thắng cảnh thiên nhiên Đông Yên Tử (chi phí cáp treo tự túc), nơi còn lưu giữ nhiều di tích lịch sử mệnh danh “Đất tổ Phật giáo Việt Nam”, chiêm bái chùa Một Mái, chùa Hoa Yên – nơi tu hành của phật hoàng Trần Nhân Tông khai sinh ra dòng mới Thiền Phái Trúc Lâm, nằm trên lưng chừng núi ở độ cao 516m. Vào tháng 2-3 hàng năm, Núi Yên Tử sẽ khoác lên mình chiếc áo cà sa vàng rực rỡ của “Đại lão mai vàng”, thu hút hàng ngàn du khách đến thưởng ngoạn phong cảnh hùng vĩ của dãy Yên Tử. 
    <h3>Nghỉ đêm tại Hạ Long.</h3>
    <h2>Ngày 6 - HẠ LONG – NINH BÌNH 03 Bữa ăn: (Sáng, Trưa, Chiều)</h2>
    Quý khách ăn sáng và trả phòng khách sạn. Xe đưa quý khách ra bến tàu, xuống thuyền du ngoạn Vịnh Hạ Long - Thắng cảnh thiên nhiên tuyệt đẹp và vô cùng sống động, được UNESCO công nhận là di sản thiên nhiên Thế giới năm 1994.
    
    - Động Thiên Cung là một trong những động đẹp nhất ở Hạ Long. Vẻ đẹp nguy nga và lộng lẫy bởi những lớp thạch nhũ và những luồng ánh sáng lung linh.
    
    - Từ trên tàu ngắm nhìn các hòn đảo lớn nhỏ trong Vịnh Hạ Long: Hòn Gà Chọi, Hòn Lư Hương.
    
    Xe đón Quý khách tại bến thuyền khởi hành đi Ninh Bình - vùng đất mệnh danh là “Nơi mơ đến, chốn mong về” với nhiều di tích văn hóa, thiên nhiên vô cùng đặc sắc.
    
    Buổi tối quý khách tự do khám phá Phố cổ Hoa Lư, một không gian check-in cổ, đẹp, trầm mặc đẹp trở nên lung linh, huyền ảo hơn với sắc màu của những chiếc đèn lồng và Bảo Tháp trên Hồ Kỳ Lân; trải nghiệm nhiều hoạt động trò chơi dân gian và nhiều loại hình văn hóa nghệ thuật từ dân tộc như múa rối nước, nhảy múa Tắc Xình, hát xẩm, ... đến những buổi trình diễn acoustic sẽ được diễn ra vào các buổi tối ngày cuối tuần.
    <h3>Nghỉ đêm tại Ninh Bình.</h3>
    <h2>Ngày 7 - NINH BÌNH – ĐÀ NẴNG 02 Bữa ăn: (Sáng, Trưa)</h2>
    Quý khách ăn sáng và trả phòng khách sạn. Xe đưa quý khách tham quan
    
    - Khu Du Lịch Tràng An: Quý khách lên thuyền truyền thống đi tham quan thắng cảnh hệ thống núi đá vôi hùng vĩ và các thung lũng ngập nước, thông với nhau bởi các dòng suối tạo nên các hang động ngập nước quanh năm. Điểm xuyến trong không gian hoang sơ, tĩnh lặng là hình ảnh rêu phong, cổ kính của các mái đình, đền, phủ nằm nép mình dưới chân các dãy núi cao.
    - Chùa Bái Đính, một quần thể chùa với nhiều kỷ lục Việt Nam như pho tượng phật Di Lặc bằng đồng nặng 80 tấn, hành lang với 500 tượng vị La Hán, tòa Bảo Tháp cao 99m… 
    
    Tiếp tục hành trình, xe khởi hành đưa Quý khách ra sân bay Nội Bài làm thủ tục đón chuyến bay về Đà Nẵng . Xe và HDV đón quý khách tại sân bay Đà Nẵng đưa về khách sạn nhận phòng nghỉ ngơi.
    <h3>Nghỉ đêm tại Đà Nẵng.</h3>
    <h2>Ngày 8 - ĐÀ NẴNG – HUẾ 03 Bữa ăn: (Sáng, Trưa, Chiều)</h2>
    Dùng bữa sáng tại khách sạn. Xe đón quý khách tại sân bay Đà Nẵng, lên đường đi Huế. Trên đường dừng tham quan:
    
    - Đầm Lập An: Ngắm cảnh mây bồng bềnh trên những chóp núi bao bọc quanh đầm,..
    
    - Mua sắm đặc sản mè xửng Thiên Hỷ
    
    - Chùa Thiên Mụ: ngôi chùa được xem là biểu tượng xứ Huế và là nơi lưu giữ nhiều cổ vật quý giá không chỉ về mặt lịch sử mà còn cả về nghệ thuật.
    
    - Đại Nội: hoàng cung xưa của 13 vị Vua triều Nguyễn, tham quan Ngọ Môn, Điện Thái Hòa, Tử Cấm Thành, Thế Miếu, Hiển Lâm Các, Cửu Đình.
    
    - Dạo Phố Đêm: trải nghiệm một Huế về đêm không hề trầm mặc với các công trình trải theo chiều dài lịch sử mà như một thiếu nữ trẻ trung khoác lên mình bộ cánh sắc màu căng tràn nhựa sống với tại Phố đi bộ ven sông Hương hài hòa với vẻ lung linh cầu Trường Tiền, tranh thêu XQ, tự do thưởng thức các món đường phố xứ Huế như bánh mì lọc, chè Huế, ngắm nhìn thuyền rồng ngược xuôi bên bến Tòa Khâm văng vẳng âm vang điệu hò Huế. Khám phá khu phố Tây sôi động về đêm với nhiều quán xá đông vui, những hàng quà lưu niệm.
    <h3>Nghỉ đêm tại Huế.</h3>
    <h2>Ngày 9 - HUẾ - ĐỘNG THIÊN ĐƯỜNG – ĐỘNG PHONG NHA 03 Bữa ăn: (Sáng, Trưa, Chiều)</h2>
    Dùng bữa sáng khách sạn. Quý khách khởi hành sớm đi Quảng Bình, đoàn ghé tham quan:
    - Động Phong Nha: Nằm trong quần thể Di sản thiên nhiên thế giới Phong Nha - Kẻ Bàng, được xem như chốn thần tiên bởi hệ thống núi đá vôi và sông ngầm dài nhất thế giới.
    
    - Động Thiên Đường: Một trong những hang động kỳ vĩ nhất thế giới, được xem như hoàng cung dưới lòng đất, một nhánh thuộc Quần thể di sản thiên nhiên thế giới Vườn Quốc Gia Phong Nha Kẻ Bàng. 
    
    Sau khi tham quan, đoàn khởi hành về khách sạn, nhận phòng tự do nghỉ ngơi và khám phá Quảng Bình về đêm.
    <h3>Nghỉ đêm tại Quảng Bình.</h3>  
    <h2>Ngày 10 - QUẢNG BÌNH – LA VANG – LẬP AN – ĐÀ NẴNG 03 Bữa ăn: (Sáng, Trưa, Chiều)</h2>
    Dùng bữa sáng tại khách sạn. Quý khách khởi hành về Đà Nẵng, trên đường đi dừng tham quan:
    - Thành cổ Quảng Trị: nghe hướng dẫn viên thuyết minh Khu phi quân sự DMZ và Cầu Hiền Lương Sông Bến Hải (Vĩ tuyến 17).
    - Thánh địa La Vang: một trong bốn tiểu vương cung thánh đường La Mã tại Việt Nam.
    - Lucky Pearl: là một trong những điểm đến thân thuộc của người dân xứ Huế chuyên tìm kiếm những nguồn ngọc trai chất lượng và đưa đến khách hàng những sản phẩm tinh tế nhất, cho Quý khách trải nghiệm đẳng cấp
    - Bán đảo Sơn Trà và viếng Chùa Linh Ứng: Nơi đây có tượng Phật Quan Thế Âm cao nhất Việt Nam. Đứng nơi đây, quý khách sẽ được chiêm ngưỡng toàn cảnh thành phố, núi rừng và biển đảo Sơn Trà một cách hoàn hảo nhất.
    
    Buổi tối Quý khách tự túc đi dạo phố thưởng ngoạn cảnh đẹp của Đà Nẵng về đêm, ngắm nhìn Cầu Rồng, Cầu Tình Yêu, Cầu Trần Thị Lý, Trung Tâm Thương Mại, Khu phố ẩm thực, Café - Bar - Disco…. 
    <h3>Nghỉ đêm tại Đà Nẵng.</h3>  
    <h2>Ngày 11 - ĐÀ NẴNG – BÀ NÀ – SƠN TRẢ - HỘI AN 03 Bữa ăn: (Sáng, Trưa, Chiều)</h2>
    Dùng bữa sáng tại khách sạn. Xe đưa Quý khách đi tham quan: 
    - Bãi biển Mỹ Khê: Một trong những bãi biển quyến rũ nhất hành tinh, Quý khách tự do dạo biển, chụp hình. 
    - Khu du lịch Bà Nà (chi phí cáp treo & ăn trưa tự túc): tận hưởng không khí se lạnh của Đà Lạt tại miền Trung, đoàn tự do tham quan Chùa Linh Ứng, Hầm Rượu Debay, vườn hoa Le Jardin D’Amour, Khu Tâm linh mới của Bà Nà viếng Đền Lĩnh Chúa Linh Từ, khu vui chơi Fantasy Park, tự do chụp hình tại Cầu Vàng điểm tham quan siêu hot tại Bà Nà… Ăn trưa tại Bà Nà tự túc. Sau đó đoàn tiếp tục tham quan vui chơi đến giờ xuống cáp. 
    - Làng Đá Non Nước Nguyễn Hùng: mua sắm sản phẩm đá mỹ nghệ tạo phong thủy cho tổ ấm hoặc làm quà tặng ý nghĩa cho người thân và bạn bè.
    
    Buổi chiều tiếp tục hành trình đến với Hội An: 
    - Phố Cổ Hội An: Chùa Cầu, Nhà Cổ Phùng Hưng, Hội Quán Phước Kiến, Cơ sở Thủ Công Mỹ Nghệ,… Tự do thả đèn hoa đăng cầu sức khỏe bình an & phúc lộc năm mới trên dòng sông Hoài…. (chi phí tự túc).
    Đoàn quay về Đà Nẵng, nhận phòng khách sạn, tự do nghỉ ngơi. 
    <h3>Nghỉ đêm tại Đà Nẵng.</h3>
    <h2>Ngày 12 - ĐÀ NẴNG - TPHCM 01 Bữa ăn: (Sáng)</h2>
    Dùng bữa sáng tại khách sạn.
    
    Mua sắm đặc sản phố biển tại Thiên Phú và Giao Mart: với hơn 2000 sản phẩm đặc sản Đà Nẵng, Miền Trung và các vùng miền lân cận, nổi bật nhất là chả bò, bò khô, mực rim me, mực khô, ghẹ sữa sốt và đầy đủ các loại khô cá,...
    
    Xe tiễn Quý khách ra sân bay Đà Nẵng đón chuyến bay trở về Tp.Hồ Chí Minh. Chia tay Quý khách và kết thúc chương trình du lịch tại sân bay Tân Sơn Nhất. 
</pre>', 19990000, 14, 'on'),

('Đà Lạt - Thác Dambri - Đồi Chè Cầu Đất - Samten Hills Dalat - Chiêm ngưỡng Đại Bảo Tháp Kinh Luân lớn nhất thế giới',
'2023-12-03', '2023-12-07', 'TP. Hồ Chí Minh', '
<pre><h2>Ngày 1 - TP. HỒ CHÍ MINH - THÁC DAMBRI - ĐÀ LẠT Số bữa ăn: 3 bữa (Ăn sáng, trưa, tối)</h2>
    Quý khách tập trung tại V Travel (190 Pasteur, phường Võ Thị Sáu, Quận 3, TP.HCM), xe đưa đoàn khởi hành đi Đà Lạt. Trên đường đoàn dừng chân tham quan và ăn trưa tại Bảo Lộc:
    
    - Thác DamBri: được coi là ngọn thác lớn nhất vùng đất Lâm Đồng với chiều cao 60m tạo thành 2 dòng chảy cao thấp rất hùng vĩ. Khu du lịch thác Đamb’ri là một quần thể du lịch bao gồm khu vui chơi, hồ, thác và rừng nguyên sinh rộng hàng nghìn hecta. Nơi đây có “ống trượt dài nhất Đông Nam Á” với độ dài 1.650 m
    
    Tiếp tục hành trình đến với thành phố sương mù, Quý khách dùng bữa tối và nhận phòng nghỉ ngơi. 
    <h3>Nghỉ đêm tại Đà Lạt.</h3>
    <h2>Ngày 2 - ĐÀ LẠT – ĐỒI CHÈ CẦU ĐẤT – HẦM VANG ĐÀ LẠT – THĂM VƯỜN DÂU TÂY Số bữa ăn: 3 bữa (Ăn sáng, trưa, tối)</h2>
    Đà Lạt chào đón quý khách với không khí se lạnh thoang thoảng mùi sương sớm mai, sau khi dùng bữa sáng, xe đưa đoàn tham quan:
    
    • Chiêm ngưỡng đồi chè Cầu Đất – check-in tua bin điện gió: trên đầu là bầu trời xanh ngát với làn mây trắng bay bay, bên dưới là thảm trà xanh tươi tắn, ở giữa là những cánh đồng quạt gió trắng quay đều tuyệt đẹp không chỉ đưa lữ khách hòa mình vào thiên nhiên khoáng đạt mà còn ngẫu nhiên kết hợp những gam màu hài hòa, mang đến những bức ảnh vô cùng nên thơ. 
    
    • Tìm hiểu và thưởng thức rượu vang tại Hầm Vang Đà Lạt, Quý khách sẽ được: 
    - Khám phá hầm vang duy nhất và lớn nhất đạt tiêu chuẩn châu Âu tại Việt Nam, đắm mình trong một không gian độc đáo của kiến trúc và mùi hương, ngắm nhìn những mái vòm theo lối kiến trúc Trung cổ 
    - Được lắng nghe những câu chuyện đầy hấp dẫn về người làm vang qua từng thời kỳ
    - Trải nghiệm 01 ly rượu vang với hương vị thanh khiết được ngâm ủ trong những thùng gỗ sồi sẽ mang lại cho khách tham quan đầy đủ trải nghiệm về một hầm vang Châu Âu đặc trưng nhất
    
    Buổi chiều, đoàn tiếp tục tham quan:
    • Vườn dâu Hiệp Lực: là một trong những vườn dâu tại Đà Lạt đạt chất lượng cao với các giống dâu đa dạng như New Zealand và Pháp. Đến nơi đây, ngoài việc được tìm hiểu phương pháp trồng dâu Quý khách còn được thoả sức tạo dáng check-in bên những giàn dâu đỏ mộng, trải nghiệm hái dâu và mua về làm quà cho người thân, bạn bè (chi phí tự túc).
    
    • Quảng trường Lâm Viên: Điểm nhấn của TP. Đà Lạt bên bờ hồ Xuân Hương với công trình nghệ thuật bông hoa dã quỳ và nụ hoa Atiso khổng lồ được thiết kế bằng kính màu, lấp lánh phản chiếu đẹp mắt bởi ánh sáng.
    Buổi tối, đoàn tự do uống café quanh khu vực Hồ Xuân Hương hay thưởng thức ly sữa đậu nành nóng hổi, bánh tráng nướng đặc sản Đà Lạt khu vực Tăng Bạt Hổ.    
    <h3>Nghỉ đêm tại Đà Lạt.</h3>
    <h2>Ngày 3 - ĐÀ LẠT – MONGO LAND Số bữa ăn: 2 bữa (Ăn sáng, trưa, tự túc ăn tối)</h2>
    Sau khi dùng bữa sáng tại khách sạn, xe đưa đoàn tham quan:
    - Mongo Land: mang vẻ đẹp hoàn toàn mới lạ - một ""tiểu Mông Cổ thu nhỏ"" trong lòng Đà Lạt được thiết kế như một nông trại với những chiếc lều đủ màu sắc. Tất cả đều được bài trí độc đáo, bắt mắt theo phong cách Mông Cổ đặc trưng. Đến đây, ngoài việc tận hưởng bầu không khí trong lành và chiêm ngưỡng vẻ đẹp của thiên nhiên hùng vĩ, Quý khách sẽ được trải nghiêm:
    - Thỏa thích chụp ảnh tại lều mông cổ, xích đu, nông trại âu, thảm cỏ, sa mạc xương rồng,…
    - Hòa mình vào thế giới của động vật: hươu sao, dê mini, cừu, thỏ Việt, thỏ Holland Lop Hà Lan, thỏ Sư Tử, chim Yến, Chinchilla, sóc Chipmunk,… và tự tay cho thú ăn (thức ăn sẽ được Mongo Land chuẩn bị sẵn cho quý khách). 
    - Tham gia các hoạt động vui chơi như: trượt cỏ, bắn cung
    - Trở thành những cô nàng, chàng trai du mục thực thụ khi diện trên mình trang phục người Mông Cổ. (Chi phí thuê trang phục tự túc).
    - Mua sắm đặc sản Đà Lạt tại cơ sở mứt Thanh Nhu: các loại trái cây sấy giòn, sấy dẻo, nước cốt dâu tằm – dâu tươi, trà atiso, trà hoa, ...
    
    Đoàn dùng bữa trưa và về lại khách sạn tự do nghỉ ngơi. Buổi chiều Quý khách có thể lựa chọn tham gia các trải nghiệm độc đáo như:
    - Vào 16h30 đón hoàng hôn và thưởng thức bữa tiệc âm nhạc cùng Amazing Show với không gian ngoài trời và có tầm nhìn xuống thành phố Đà Lạt thơ mộng. Hoặc vào 19h00 thưởng thức những bản nhạc trữ tình xưa, nhạc Trịnh, nhạc Bolero tại ‘‘Âm sắc Đà Lạt – Cung Đàn Xưa’’, Quý khách có dịp trải nghiệm một phong cách sống “chậm” và tận hưởng từng phút giây, lưu giữ những khoảnh khắc tuyệt vời ở tận sâu trong tâm hồn mỗi người. (Chi phí tự túc)
    - Tham gia chương trình chèo thuyền Sup và ngắm hoàng hôn trên hồ Tuyền Lâm là hoạt động ngoài trời mang đến cho quý khách cảm xúc vui vẻ, thư giãn để thưởng thức cảnh đẹp của thiên nhiên trên hồ. Đặc biệt cùng chụp những bức hình “ sống ảo” rất chill, check-in bãi cỏ lau, rừng ngập nước,… thưởng thức ly trà, cà phê thơm lừng và xì xụp mì ly xúc xích. (Chi phí tự túc)
    - Trải nghiệm tắm khoáng nóng & xông hơi tại Dlat’s giúp bạn thư giãn và nghỉ ngơi, giải tỏa căng thẳng (Chi phí tự túc)
    
    ***Lưu ý: Chi phí vé và đi lại tự túc***
    
    Buổi tối Quý khách tự do tản bộ Chợ Đà Lạt và thưởng thức ẩm thực địa phương: lẩu bò, lẩu gà lá é, bánh ướt lòng gà, bánh căn,....     
    <h3>Nghỉ đêm tại Đà Lạt</h3>
    <h2>Ngày 4 - ĐÀ LẠT – SAMTEN HILLS ĐÀ LẠT - TP. HỒ CHÍ MINH Số bữa ăn: 2 bữa (Ăn sáng, trưa)</h2>
    Quý khách dùng bữa sáng, làm thủ tục trả phòng. Sau đó xe và HDV đưa khách đi tham quan: 
    
    - Samten Hills Dalat: là một khu du lịch trải nghiệm về văn hóa tâm linh vừa đi vào hoạt động từ cuối tháng 2/2023. Lấy cảm hứng từ kiến trúc độc đáo của văn hóa Tây Tạng, kết hợp với phong cách thiết kế hiện đại, tất cả đã tạo nên một không gian Văn hóa Tâm linh Phật giáo Kim Cương Thừa – Drigung Kagyu Samten Ling Việt Nam. Với điểm nhấn nổi bật là Đại bảo tháp Kinh Luân bằng đồng nguyên chất dát vàng 24K lớn nhất thế giới đã được xác lập kỷ lục Guinness. 
    
    Khởi hành về TP. Hồ Chí Minh, đoàn dừng tại Bảo Lộc dùng cơm trưa, sau đó khởi hành về điểm đón ban đầu. Chia tay đoàn và kết thúc chương trình du lịch.
</pre>', 3590000, 7, 'on'),

('Cung Đường Biển - Hoa: Phan Thiết - Khu Du Lịch Núi Tà Cú - Đồi Cát Vàng - Samten Hills Đà Lạt - Trang Trại rau và hoa
Vạn Thành', '2023-12-05', '2023-12-09', 'TP. Hồ Chí Minh', '
<pre><h2>Ngày 1 - TP. HỒ CHÍ MINH – TÀ CÚ – PHAN THIẾT Số bữa ăn 3 bữa: (Sáng, Trưa, Chiều)</h2>
    Quý khách tập trung tại công ty V Travel (190 Pasteur, P. Võ Thị Sáu, Q3, TP.HCM). Đoàn khởi hành đi Hàm Thuận Nam và dùng bữa sáng. Trên đường, đoàn dừng chân tham quan:
    
    • Khu du lịch Tà Cú: Viếng cảnh chùa linh thiêng - Linh Sơn Trường Thọ và Chùa Linh Sơn Long Đòa, chiêm ngưỡng Tượng Phật Thích Ca Niết Bàn - tượng Phật dài nhất nằm trên đỉnh núi. Tham quan rừng nguyên sinh - Khu Bảo Tồn Quốc Gia Tà Cú và không quên chek in cầu thang 7 sắc, vườn hồng hạc, bình trà khổng lồ, vườn hoa hướng dương. 
    
    Sau bữa trưa Đoàn tiếp tục hành trình. Đến Phan Thiết, Quý khách nhận phòng và nghỉ ngơi. 
    
    Xe đưa quý khách đến tham quan và chiêm ngưỡng hoàng hôn rực rỡ tại:
    • Đồi Cát Vàng: Một trong những khu vực đẹp nhất nằm ở Mũi Né thu hút khá nhiều du khách do hình dáng đẹp của cát và màu sắc của cát, nơi đây được xem là đồi cát có một không hai tại Việt Nam bắt nguồn từ mỏ sắt cổ tồn tại hàng trăm năm tạo nên. 
    
    Buổi tối, Quý khách dùng bữa tối tại nhà hàng địa phương với các món ăn được chế biến từ các loại hải sản tươi ngon và dạo phố khám phá Mũi Né về đêm.
    <h3>Nghỉ đêm tại Phan Thiết.</h3>
    <h2>Ngày 2 - PHAN THIẾT – ĐÈO ĐẠI NINH – SAMTEN HILLS – ĐÀ LẠT Số bữa ăn 3 bữa: (Sáng, Trưa, Chiều)</h2>
    Buổi sáng, Quý khách tự do tắm biển thư giãn tại resort. Làm thủ tục trả phòng và xe đưa đoàn khởi hành tham quan:
    • Mua sắm đặc sản Phan Thiết tại Đặc Sản Hương Đà – Phan Thiết (chi phí tự túc) - nước mắm Phan Thiết, các loại hản sản khô như: mực khô câu, mực một nắng, cá cơm rút xương, cá thu một nắng, cá đù một nắng…..về làm quà cho người thân và bạn bè.
    
    • Làng Chài Xưa Mũi Né: với lịch sử 300 năm cái nôi của nghề làm nước mắm, trải nghiệm cảm giác lao động trên đồng muối, đi trên con đường rạng xưa, thăm phố cổ Phan Thiết, thăm nhà lều của hàm hộ nước mắm xưa, đắm chìm cảm xúc trong biển 3D và thích thú khi đi chợ làng chài xưa với bàn tính tay, bàn cân xưa thú vị,… 
    
    Đoàn dùng bữa trưa đặc biệt với món ẩm thực địa phương “Lẩu thả” trứ danh của vùng đất Mũi Né.  Khởi hành đi Đà Lạt theo con đường mới Lương Sơn qua ngọn đèo Đại Ninh đi đến Di Linh, ngang qua nhà máy thủy điện Đại Ninh. Trên đường đi, đoàn dừng chân tham quan:
    
    • Samten Hills Đà Lạt: là một khu du lịch trải nghiệm về văn hóa tâm linh vừa đi vào hoạt động từ cuối tháng 2/2023. Lấy cảm hứng từ kiến trúc độc đáo của văn hóa Tây Tạng, kết hợp với phong cách thiết kế hiện đại, tất cả đã tạo nên một không gian Văn hóa Tâm linh Phật giáo Kim Cương Thừa – Drigung Kagyu Samten Ling Việt Nam. Với điểm nhấn nổi bật là Đại bảo tháp Kinh Luân bằng đồng nguyên chất dát vàng 24K lớn nhất thế giới đã được xác lập kỷ lục Guinness. 
    
    Đến Đà Lạt, xe đưa đoàn về khách sạn nhận phòng và nghỉ ngơi. Buổi tối Quý khách dùng bữa tối tại nhà hàng địa phương và tự do tản bộ tham quan chợ đêm Đà Lạt về đêm và khám phá ẩm thực đường phố độc đáo của Đà Lạt như bánh tráng nướng phố Xuân Diệu, sữa đậu nành Tăng Bạt Hổ, Kem Bơ, xiên nướng,…
    <h3>Nghỉ đêm tại Đà Lạt.</h3>
    <h2>Ngày 3 - ĐÀ LẠT – FRESH GARDEN Số bữa ăn 2 bữa: (Sáng, Trưa, Tự Túc Ăn Chiều)</h2>
    Đà Lạt chào đón du khách với không khí lạnh tràn về, sau khi dùng bữa sáng, xe đưa đoàn tham quan:
    
    • Nhà Thờ Domain de Marie: theo dòng nữ tu Bác Ái, tọa lạc trên đồi Mai Anh, nổi bật với màu hồng sáng rực. Quý khách có thể chọn cho mình những món đồ từ len trong khuôn viên phía sau nhà thờ.
    
    • Fresh Garden: là một trong những khu du lịch có đồi hoa đẹp tại Đà Lạt với view rừng nguyên sinh. Đến đây, quý khách sẽ đắm chìm trong khung cảnh thiên nhiên rộng lớn đầy thơ mộng với ngàn hoa đua nở. Nổi bật giữa Fresh Garden là cánh đồng hoa bát ngát ngập sắc màu. Bên cạnh đó còn có các tiểu cảnh vô cùng độc đáo, mới lạ & duy nhất như: đường hầm nhiệt đới, đường hầm thời gian, hồ view rừng, cổng trời,...
    
    • Mua sắm đặc sản Đà Lạt tại cơ sở mứt Thanh Nhu: các loại trái cây sấy giòn, sấy dẻo, nước cốt dâu tằm – dâu tươi, trà atiso, trà hoa, ...
    
    Đoàn dùng bữa trưa và về lại khách sạn tự do nghỉ ngơi. Buổi chiều Quý khách có thể tự túc lựa chọn tham gia các trải nghiệm độc đáo như:
    
    • Vào 16h30 đón hoàng hôn và thưởng thức bữa tiệc âm nhạc cùng Amazing Show với không gian ngoài trời và có tầm nhìn xuống thành phố Đà Lạt thơ mộng. Hoặc vào 19h00 thưởng thức những bản nhạc trữ tình xưa, nhạc Trịnh, nhạc Bolero tại ‘‘Âm sắc Đà Lạt – Cung Đàn Xưa’’, Quý khách có dịp trải nghiệm một phong cách sống “chậm” và tận hưởng từng phút giây, lưu giữ những khoảnh khắc tuyệt vời ở tận sâu trong tâm hồn mỗi người. (Chi phí tự túc)
    
    • Trải nghiệm tắm khoáng nóng và xông hơi tại Dlat’s giúp bạn thư giản và nghỉ ngơi, giải tỏa căng thẳng (Chi phí tự túc)
    
    ***Lưu ý: Chi phí vé và đi lại tự túc***
    <h2>Ngày 4 - ĐÀ LẠT – TRANG TRẠI RAU VÀ HOA VẠN THÀNH Số bữa ăn 2 bữa: (Sáng, Trưa)</h2>
    Quý khách dùng bữa sáng, làm thủ tục trả phòng. Sau đó xe và HDV đưa khách tham quan:
    
    • Trang trại rau và hoa Vạn Thành: du khách sẽ choáng ngợp bởi vẻ quyến rũ của bức tranh tuyệt mỹ được tạo nên bởi vô vàn các loài hoa đua nhau khoe sắc như đóa Hồng, Cẩm Chướng, Lily, Đồng Tiền, Cẩm Tú Cầu… Ngoài ra, Quý khách còn được khám phá quy trình trồng những loại nông sản và thỏa sức chụp hình tại vườn cà chua, bí khổng lồ, dưa Pepino, dâu và các loại rau trồng thủy canh (tùy theo mùa).
    
    Đoàn dùng cơm trưa, sau đó khởi hành về điểm đón ban đầu. Chia tay Quý khách và kết thúc chương trình du lịch.
</pre>', 4290000, 8, 'on'),

('Hành trình Hoa và Biển: Đà Lạt - Nha Trang', '2023-12-06', '2023-12-11', 'TP. Hồ Chí Minh', '
<pre><h2>Ngày 1 - TP. HỒ CHÍ MINH – ĐÀ LẠT Số bữa ăn: 3 bữa (Ăn sáng, trưa, chiều)</h2>
    Quý khách tập trung tại V Travel (190 Pasteur, phường Võ Thị Sáu, quận 3, TP.HCM), xe đưa đoàn khởi hành đi Đà Lạt. Trên đường đi Quý khách ghé tham quan:
    
    - Thác Bobla: đẹp như một bức tranh thiên nhiên với dòng thác nguyên sơ, hùng vĩ cao hơn 40m, rộng hơn 20m, cùng cảnh quan được tôn tạo tuyệt đẹp, lưu giữ nhiều cây cổ thụ hàng trăm năm tuổi, phía xa hút tầm mắt là những đồi chè, cà phê xanh mát.
    - Ga Đà Lạt: nhà ga cổ kính nhất Việt Nam và Đông Dương, có phong cách kiến trúc độc đáo với ba mái hình chóp cách điệu như ba đỉnh núi Langbiang và nhà rông Tây Nguyên.
    
    Đến Đà Lạt sau khi ăn chiều, Quý khách nhận phòng khách sạn nghỉ ngơi
    
    Buổi tối, Quý khách tự do dạo phố thưởng thức ẩm thực nổi tiếng phố núi: Lẩu gà lá é Tao Ngộ, Lẩu bò quán Gỗ, Bánh ướt lòng gà, Ốc nhồi thịt, Xe lẩu buffet, Ngói BBQ … hoặc đến Nhạc Quán Diễm Xưa lắng nghe những tình khúc bất hủ của nhạc sỹ Trịnh Công Sơn … (chi phí tự túc).    
    <h3>Nghỉ đêm tại Đà Lạt.</h3>
    <h2>Ngày 2 - ĐÀ LẠT - THÀNH PHỐ NGÀN HOA Số bữa ăn: 3 bữa (Ăn sáng, trưa, chiều)</h2>
    Sau khi dùng bữa sáng tại khách sạn, Quý khách khởi hành đi tham quan:
    
    - Đường Hầm Đất Sét: các công trình nghệ thuật với những tác phẩm điêu khắc bằng đất nung hoành tráng, ấn tượng được sách Kỷ Lục Việt Nam công nhận như: Ga xe lửa, dinh Bảo Đại, Đại học Đà Lạt, nhà thờ Con Gà, sân bay Liên Khương, đường cao tốc, hồ Tuyền Lâm, thung lũng Tình yêu… Nổi tiếng là “hồ vô cực” thu hút nhiều du khách đến tham quan hiện nay.
    
    Ăn trưa, đoàn về khách sạn nghỉ ngơi. Buổi chiều đoàn tiếp tục tham quan:
    
    - KDL Cao Nguyên Hoa: với diện tích hơn 122ha, là nơi bảo tồn đa dạng sinh học đặc biệt là các lòai hoa thân gỗ không chỉ có ở Đà Lạt mà còn trên toàn Thế giới với mảng xanh của rừng - thảm cỏ tự nhiên rộng khắp, điểm xuyến những khóm hoa Thanh Anh nhẹ nhàng dọc lối đi. Đến đây Quý khách sẽ được trải nghiệm: 
    - Quán Seven-T Coffee nằm giữa rừng thông với view 360° núi đồi xanh mát, bể bơi vô cực giữa rừng nhiệt đới 
    - Xả stress và ghi lại những khoảnh khắc đẹp với Đà Lạt Swing – trò chơi “xích đu tiên” lớn nhất Việt Nam. 
    - Rose Garden – Vườn hoa hồng với hàng trăm gốc hồng ngoại, hồng nội, hồng cổ thụ quý hiếm tỏa hương khoe sắc bốn mùa. 
    - Con đường rừng nhiệt đới dẫn lối đến gốc si cổ thụ nghìn năm huyền bí và cổ kính. 
    - Thoả sức chụp hình check in với dàn siêu xe cực chill, cực chất hay ngôi nhà phù thủy, đồi mai anh đào, đồi huệ sông nile, đồi hoa sim tím, đồi hoa hoàng yến,…
    - Trang trại rau và hoa Vạn Thành: du khách sẽ choáng ngợp bởi vẻ quyến rũ của bức tranh tuyệt mỹ được tạo nên bởi vô vàn các loài hoa đua nhau khoe sắc như đóa Hồng, Cẩm Chướng, Lily, Đồng Tiền, Cẩm Tú Cầu… Ngoài ra, Quý khách còn được khám phá quy trình trồng những loại nông sản và thỏa sức chụp hình tại vườn cà chua, bí khổng lồ, dưa Pepino, dâu và các loại rau trồng thủy canh (tùy theo mùa).
    - Mua sắm đặc sản Đà Lạt tại cơ sở mứt Thanh Nhu: các loại trái cây sấy giòn, sấy dẻo, nước cốt dâu tằm – dâu tươi, trà atiso, trà hoa, ...
    <h3>Nghỉ đêm tại Đà Lạt.</h3> 
    <h2>Ngày 3 - ĐÀ LẠT - NHA TRANG Số bữa ăn: 3 bữa (Ăn sáng, trưa, chiều)</h2>
    Sau khi dùng bữa sáng, đoàn khởi hành tham quan:

    - Fairytale Land & hầm rượu vang Vĩnh Tiến: đến đây du khách như lạc vào khu vườn cổ tích của những chú lùn Hobbiton, điểm xuyến trong khu vườn là những ngôi nhà độc đáo và đầy sắc màu, những bức vẽ trên tường đầy lôi cuốn và những thảm hoa nhỏ không kém phần quyến rũ. Dạo một vòng quanh khu vườn đừng quên rảo bước vào hầm rượu vang với hơn 10.000 chai đang được lưu trữ dưới hầm.
    
    Quý khách ăn trưa, đoàn tiếp tục khởi hành đi Nha Trang. 
    <h3>Nghỉ đêm tại Nha Trang.</h3>
    <h2>Ngày 4 - NHA TRANG - HÒN LAO - VINWONDERS NHA TRANG Số bữa ăn: 2 bữa (Ăn sáng, trưa, tự túc ăn chiều)</h2>
    Sau khi dùng buffet sáng tại khách sạn, xe đưa đoàn đến cảng xuống tàu du ngoạn và tham quan:
    
    - Hòn Lao - Đảo Khỉ: nơi có hơn 1000 chú khỉ đang được bảo tồn và sinh sống tự nhiên. Quý khách tự do tắm biển, thư giãn, tham quan xem chương trình biểu diễn xiếc Khỉ, đua chó, khỉ bơi lội hoặc trải nghiệm các môn thể thao trên bãi biển và trò chơi: canô kéo dù, mô tô nước, đua xe công thức 1, bắn súng sơn, cưỡi đà điểu … (chi phí tự túc).
    
    Sau khi dùng bữa trưa, Quý khách quay về trung tâm thành phố. Buổi chiều Quý khách ăn chiều tự túc và tự do nghỉ ngơi tại khách sạn hoặc tự túc chi phí lựa chọn 1 trong 2 điểm tham quan như sau:
    
    - Lựa chọn 1: Vinwonders Nha Trang (chi phí tự túc): Quý khách tự do tham quan vui chơi trong khuôn viên với những lâu đài châu Âu tráng lệ, cáp treo hình tháp Eiffel, Đồi Vạn Hoa,.. Dạo bước trong không gian này vào ban ngày, du khách tưởng như mình đang lạc vào một phố cổ nào đó của phương tây. Đêm xuống, cảnh vật trở nên lung linh hơn bao giờ hết bởi đèn trang trí trong các lâu đài, khu vui chơi, tạo nên vẻ đẹp huyền ảo, thần tiên. Tự do Tham gia những trò chơi như tháp rơi tự do Sky Drop, trượt ván Alpine Coaster, tàu lượn cao tốc Roller Coaster, đu dây văng sẽ thích hợp với các bạn yêu thích cảm giác mạnh tạo ra từ các cú xoay, lộn nhào trên không trung, lật nghiêng. Quý khách có thể dạo bước trong thế giới Thuỷ Cung, tại đây có hơn 300 loại sinh vật biển quý hiếm từ nhiều quốc gia khác nhau hội tụ về. Đặc biệt, Thủy Cung Vinpearl Land Nha Trang còn mang tới cho du khách một thế giới lung linh sắc màu với các chương trình biểu diễn nghệ thuật độc đáo như biểu diễn Nàng tiên cá – nơi du khách được chiêm ngưỡng các nàng tiên cá xinh đẹp bước ra từ cổ tích, hay chương trình cho cá ăn – với những chàng thợ lặn khỏe khoắn, chơi đùa và chăm sóc các cư dân Thủy Cung. Hoặc tại Lâu đài phim 4D, Quý khách sẽ được thưởng thức công nghệ chiếu phim cực sắc nét cùng hiệu ứng 4D chân thực như đang sống trong thế giới đại dương. Ngoài ra, còn có các chương trình biểu diễn nhạc nước, biểu diễn cá heo, biểu diễn Carnival vô cùng hấp dẫn....  
    - Lựa chọn 2: du ngoạn trên du thuyền Emperor (chi phí tự túc), tàu sẽ di chuyển dọc thành phố biển Nha Trang, du khách sẽ được ngắm cảnh hoàng hôn đẹp nhất trong khi thưởng thức tiệc cocktail, bữa tối tinh tế và nghệ sỹ ghi ta, violon chơi những bản nhạc du dương trong một khung cảnh lãng mạn dưới trời sao, ánh trăng và ánh đèn rực rỡ của thành phố.
    <h3>Nghỉ đêm tại Nha Trang.</h3>
    <h2>Ngày 5 - NHA TRANG – TP.HCM Số bữa ăn: 2 bữa (Ăn sáng, trưa)</h2>
    Sau khi dùng buffet sáng và trả phòng khách sạn. Xe đưa Quý khách đi tham quan:
    
    - Ngọc trai Long Beach Pearl (đường Trương Hán Siêu): tham quan, mua sắm các sản phẩm từ ngọc trai - báu vật khơi xa kết hợp cùng sự sáng tạo của người nghệ nhân tạo thành những sản phẩm trang sức cao cấp, chất lượng cao. Không chỉ dành riêng cho phái nữ, Long Beach Pearl còn chế tác những chiếc vòng tay dây da ngọc trai dành cho nam giới. 
    - Mua sắm đặc sản phố biển tại Hương Đà Nha Trang

    Ăn trưa. Đoàn khởi hành về lại Tp.HCM. Trên đường về, đoàn dừng chân tại tham quan: 
    
    - Làng Chài Xưa: với lịch sử 300 năm cái nôi của nghề làm nước mắm, trải nghiệm cảm giác lao động trên đồng muối, đi trên con đường rạng xưa, thăm phố cổ Phan Thiết, , thăm nhà lều của hàm hộ nước mắm xưa, đắm chìm cảm xúc trong biển 3D và thích thú khi đi chợ làng chài xưa với bàn tính tay, bàn cân xưa thú vị,…
    
    Xe đưa đoàn về lại điểm đón ban đầu và kết thúc hành trình nhiều trải nghiệm.
</pre>', 4590000, 3, 'on'),

('Đà Lạt - Thác Bobla - Thung Lũng Tình Yêu Chinh Phục Cầu Kính 7D - Vườn Bonsai Hoàng Long Ohayo', '2023-12-11',
'2023-12-14', 'TP. Hồ Chí Minh', '
<pre><h2>Ngày 1 - TP. HỒ CHÍ MINH - ĐÀ LẠT Số bữa ăn: 03 bữa ăn (Sáng, trưa, chiều)</h2>
    Quý khách tập trung tại V Travel (190 Pasteur, Phường Võ Thị Sáu, Quận 3 TP.HCM). Đoàn khởi hành đi Đà Lạt. Trên đường, đoàn dừng chân tham quan:
    
    • Thác Bobla: đẹp như một bức tranh thiên nhiên với dòng thác nguyên sơ, hùng vĩ cao hơn 40m, rộng hơn 20m, cùng cảnh quan được tôn tạo tuyệt đẹp, lưu giữ nhiều cây cổ thụ hàng trăm năm tuổi, phía xa hút tầm mắt là những đồi chè, cà phê xanh mát.
    Chiều đoàn tiếp tục hành trình về Đà Lạt, nhận phòng nghỉ ngơi. Buổi tối, Quý khách tự do thưởng thức café ngắm hồ Xuân Hương về đêm.
    <h3>Nghỉ đêm tại Đà Lạt.</h3>
    <h2>Ngày 2 - THUNG LŨNG TÌNH YÊU – CHINH PHỤC CẦU KÍNH NGÀN THÔNG 7D Số bữa ăn: 02 bữa ăn (Sáng, trưa, ăn chiều tự túc)</h2>
    Đà Lạt chào đón du khách với không khí lạnh tràn về, sau khi dùng bữa sáng, xe đưa đoàn tham quan:
    • Ga Đà Lạt: nhà ga cổ kính nhất Việt Nam và Đông Dương, có phong cách kiến trúc độc đáo với ba mái hình chóp cách điệu như ba đỉnh núi Langbiang và nhà rông Tây Nguyên.
    
    • Thung Lũng Tình Yêu – Đồi Mộng Mơ: đến đây du khách như lạc vào không gian cổ tích với nhiều hoạt động thú vị như:
    
    - Khám phá như mê cung tình yêu hình trái tim màu xanh trải rộng trên diện tích 4.000m², thung lũng ngàn hoa, công trình 30 kỳ quan, bảo tàng tượng sáp… 
    
    - Check-in các không gian sắc màu của dãy phố cổ Hội An, vườn hoa lavender, cây tình yêu, cầu thang sách, đồi vọng cảnh. 
    
    - Chinh phục Cầu Kính Ngàn Thông 7D – là cây cầu kính thứ 4 tại Việt Nam và là đầu tiên của khu vực Miền Trung – Tây Nguyên. Nằm ở độ cao 1500m, cầu kính hứa hẹn sẽ là một địa điểm sống ảo và mang lại nhiều cảm xúc mới lạ cho quý khách. (chi phí cầu kính tự túc). 
    
    - Tham qua các hoạt động như: đạp vịt, Pedalo trên hồ Đa Thiện, khu trò chơi liên hoàn với các trò chơi như: giữ thăng bằng trên dây cáp (highwire); đu dây mạo hiểm tự do (zipline)... và xe điện tham quan Thung Lũng Tình Yêu.
    
    Sau bữa trưa, đoàn dừng chân mua sắm đặc sản làm quà cho người thân, bạn bè và trở về khách sạn nghỉ ngơi, tự do khám phá thành phố sương mù. 
    
    • Mua sắm đặc sản Đà Lạt tại cơ sở mứt Thanh Nhu: các loại trái cây sấy giòn, sấy dẻo, nước cốt dâu tằm – dâu tươi, trà atiso, trà hoa, ...
    
    Đoàn dùng bữa trưa và về lại khách sạn tự do nghỉ ngơi. Buổi chiều Quý khách có thể lựa chọn tham gia các trải nghiệm độc đáo như:
    
    - Vào 16h30 đón hoàng hôn và thưởng thức bữa tiệc âm nhạc cùng Amazing Show với không gian ngoài trời và có tầm nhìn xuống thành phố Đà Lạt thơ mộng. Hoặc vào 19h00 thưởng thức những bản nhạc trữ tình xưa, nhạc Trịnh, nhạc Bolero tại ‘‘Âm sắc Đà Lạt – Cung Đàn Xưa’’, Quý khách có dịp trải nghiệm một phong cách sống “chậm” và tận hưởng từng phút giây, lưu giữ những khoảnh khắc tuyệt vời ở tận sâu trong tâm hồn mỗi người.(Chi phí tự túc)
    
    - Trải nghiệm tắm khoáng nóng & xông hơi tại Dlat’s giúp bạn thư giãn và nghỉ ngơi, giải tỏa căng thẳng (Chi phí tự túc)
    
    ***Lưu ý: Chi phí vé và đi lại tự túc***
     
    Buổi tối, Quý khách tự do thưởng thức ẩm thực địa phương: lẩu bò, lẩu gà lá é, bánh ướt lòng gà, bánh căn,... (Ăn tối tự túc).
    <h3>Nghỉ đêm tại Đà Lạt.</h3>
    <h2>Ngày 3 - ĐÀ LẠT– HOÀNG LONG OHAYO - TP.HCM Số bữa ăn: 02 bữa ăn (Sáng, trưa)</h2>
    Quý khách dùng bữa sáng, làm thủ tục trả phòng. Sau đó xe và HDV đưa khách tham quan:
    
    •  Hoàng Long Ohayo: tự hào là một trong những khu vườn bonsai lá kim lớn nhất Việt Nam với những chậu cây bonsai được chăm sóc và uốn nắn kỹ lưỡng vô cùng đẹp mắt. Ngoài ra, quý khách còn được chiêm ngưỡng những loài hoa nổi tiếng của Đà Lạt, hồ cá Koi đặt tiêu chuẩn Nhật Bản, hàng loạt tiểu cảnh mang đậm sắc màu Nhật Bản như hàng cổng Tori, khu thác nước, khu phố Nhật, con đường tre,… Tất cả sẽ tạo nên một không gian thư thái hoà quyện với thiên nhiên. 
    
    Đoàn dùng cơm trưa, sau đó khởi hành về điểm đón ban đầu. Chia tay đoàn và kết thúc chương trình du lịch.
</pre>', 2590000, 7, 'on'),

('Hà Tiên - Đà Lạt - Thác Datanla - Nông Trại Cún - Đồi Chè Cầu Đất - Cánh Đồng Hoa Cẩm Tú Cầu - Samten Hills DaLat -
Chiêm ngưỡng Đại Bảo Tháp Kinh Luân lớn nhất thế giới', '2023-12-14', '2023-12-18', 'Rạch Giá', '
<pre><h2>Ngày 1 - HÀ TIÊN - TP.RẠCH GIÁ – TP.ĐÀ LẠT (Nghỉ đêm trên xe)</h2>
    17h30 tối:  Xe + HDV của V Travel đón Quý khách tại điểm hẹn trong TP. Hà Tiên. Đoàn khởi hành đi Đà Lạt.
    <h3>Quý khách nghỉ đêm trên xe.</h3>
    <h2>Ngày 2 - ĐÀ LẠT – THÁC DATANLA – FAIRYTALE LAND – NÔNG TRẠI CÚN PUPPY FARM (Ăn sáng, trưa, tối)</h2>
    Đà Lạt chào đón du khách với không khí lạnh tràn về, Quý khách ăn sáng trên đường đi và tham quan:

    - Thác Datanla – Đà Lạt là một địa điểm du lịch khá nổi tiếng tại Việt Nam. Nơi đây có phong cảnh hữu tình và rất nhiều các địa điểm tham quan nổi tiếng. Một trong những địa điểm đó có thể kể đến thác Datanla nơi sở hữu vẻ đẹp thiên nhiên hùng vĩ cùng với khí hậu ôn hòa, mát mẻ. Quý khách có thể sử dụng dịch vụ xe trượt tham quan thác (chi phí tự túc). 
    
    - Fairytale Land & hầm rượu vang Vĩnh Tiến: đến đây du khách như lạc vào khu vườn cổ tích của những chú lùn Hobbiton, điểm xuyến trong khu vườn là những ngôi nhà độc đáo và đầy sắc màu, những bức vẽ trên tường đầy lôi cuốn và những thảm hoa nhỏ không kém phần quyến rũ. Dạo một vòng quanh khu vườn đừng quên rảo bước vào hầm rượu vang với hơn 10.000 chai đang được lưu trữ dưới hầm.
    
    - Nông Trại Cún Puppy Farm: đến đây, du khách thỏa thích tạo dáng cùng những chú cún siêu dễ thương hay chọn cho mình những góc chụp đẹp bên các loài hoa với đủ màu sắc rực rỡ, vườn bí ngô, dâu tây, cà chua bi,… tựa như là một Đà Lạt thu nhỏ, vô cùng thơ mộng và lãng mạn.
    
    Buổi tối, Quý khách tự do mua sắm tham quan chợ đêm, thưởng thức các món ăn đặt sản tại chợ đêm như: Bánh tráng nướng, Kem bơ, café,…
    <h3>Nghỉ đêm tại Đà Lạt.</h3>
    <h2>Ngày 3 - ĐÀ LẠT – ĐỒI CHÈ CẦU ĐẤT – TUA BIN ĐIỆN GIÓ – MONGO LAND (Ăn sáng, trưa, tối)</h2>
    Đà Lạt chào đón du khách với không khí lạnh tràn về, sau khi dùng bữa sáng, xe đưa đoàn tham quan:

    - Đồi chè Cầu Đất – check-in tua bin điện gió: trên đầu là bầu trời xanh ngát với làn mây trắng bay bay, bên dưới là thảm trà xanh tươi tắn, ở giữa là những cánh đồng quạt gió trắng quay đều tuyệt đẹp không chỉ đưa lữ khách hòa mình vào thiên nhiên khoáng đạt mà còn ngẫu nhiên kết hợp những gam màu hài hòa, mang đến những bức ảnh vô cùng nên thơ. Ngồi nhâm nhi ly cà phê thơm lừng tại Panorama Cafe Cầu Đất tận hưởng những điều bình yên nhất của cuộc sống. (Chi phí nước uống tự túc)
    
    - Vườn hoa cẩm tú cầu: mênh mông rực rỡ trên không gian rộng hơn 2 hecta tọa lạc bên dưới những tán rừng thông xinh đẹp là điểm check in thu hút đông đảo du khách gần xa.
    
    Buổi chiều, đoàn tiếp tục tham quan:

    - Mongo Land: mang vẻ đẹp hoàn toàn mới lạ - một ""tiểu Mông Cổ thu nhỏ"" trong lòng Đà Lạt được thiết kế như một nông trại với những chiếc lều đủ màu sắc. Tất cả đều được bài trí độc đáo, bắt mắt theo phong cách Mông Cổ đặc trưng. Đến đây, ngoài việc tận hưởng bầu không khí trong lành và chiêm ngưỡng vẻ đẹp của thiên nhiên hùng vĩ, Quý khách sẽ được trải nghiêm:
    
    Thỏa thích chụp ảnh tại lều mông cổ, xích đu, nông trại âu, thảm cỏ, sa mạc xương rồng,…
    
    Hòa mình vào thế giới của động vật: hươu sao, dê mini, cừu, thỏ Việt, thỏ Holland Lop Hà Lan, thỏ Sư Tử, chim Yến, Chinchilla, sóc Chipmunk,… và tự tay cho thú ăn (thức ăn sẽ được Mongo Land chuẩn bị sẵn cho quý khách).
    
    Tham gia các hoạt động vui chơi như: trượt cỏ, bắn cung
    
    Trở thành những cô nàng, chàng trai du mục thực thụ khi diện trên mình trang phục người Mông Cổ. (Chi phí thuê trang phục tự túc).
    
    - Mua sắm đặc sản Đà Lạt tại cơ sở mứt Thanh Nhu: các loại trái cây sấy giòn, sấy dẻo, nước cốt dâu tằm – dâu tươi, trà atiso, trà hoa, ...
    
    Buổi tối Quý khách có thể (tự túc lựa chọn) tham gia các trải nghiệm độc đáo như:
    
    - Vào 19h00 thưởng thức những bản nhạc trữ tình xưa, nhạc Trịnh, nhạc Bolero tại “Âm sắc Đà Lạt – Cung Đàn Xưa”, Quý khách có dịp trải nghiệm một phong cách sống “chậm” và tận hưởng từng phút giây, lưu giữ những khoảnh khắc tuyệt vời ở tận sâu trong tâm hồn mỗi người. (Chi phí tự túc)
    
    - Trải nghiệm tắm khoáng nóng & xông hơi tại Dlat’s giúp bạn thư giãn và nghỉ ngơi, giải tỏa căng thẳng (Chi phí tự túc)
    
    ***Lưu ý: Chi phí vé và đi lại tự túc***
    
    Buổi tối Quý khách tự do tản bộ Chợ Đà Lạt thưởng thức sữa đậu nành và bánh tráng nướng tại khu phố Tăng Bạt Hổ. 
    <h3>Nghỉ đêm tại Đà Lạt.</h3>
    <h2>Ngày 4 - Ngày 4 : TP.ĐÀ LẠT – SAMTEN HILLS DA LAT - TP.HÀ TIÊN (Ăn sáng, trưa, chiều)</h2>
    Buổi sáng, trả phòng khách sạn và ăn sáng. Xe đưa Quý khách tham quan:
    
    Sau khi dùng bữa sáng tại khách sạn, xe đưa đoàn tham quan:
    
    - Samten Hills Dalat: là một khu du lịch trải nghiệm về văn hóa tâm linh vừa đi vào hoạt động từ cuối tháng 2/2023. Lấy cảm hứng từ kiến trúc độc đáo của văn hóa Tây Tạng, kết hợp với phong cách thiết kế hiện đại, tất cả đã tạo nên một không gian Văn hóa Tâm linh Phật giáo Kim Cương Thừa – Drigung Kagyu Samten Ling Việt Nam. Với điểm nhấn nổi bật là Đại bảo tháp Kinh Luân bằng đồng nguyên chất dát vàng 24K lớn nhất thế giới đã được xác lập kỷ lục Guinness. 
     
    Đoàn dừng tại Bảo Lộc dùng cơm trưa, sau đó khởi hành về Tp.Rạch Giá. Về đến Tp.Rạch Giá, Hướng dẫn viên chia tay đoàn và kết thúc chương trình du lịch.
    
    Tối: Đến Hà Tiên, HDV đưa khách về lại điểm đón ban đầu, chia tay đoàn và hẹn gặp lại quý khách trong những chuyến tham quan tiếp theo!!!
</pre>', 4290000, 5, 'on'),

('Phú Quốc: Dịch vụ vé máy bay + 2 đêm nghỉ dưỡng tại Radisson Blu Phú Quốc 5 Sao', '2023-12-03', '2023-12-06', 'TP. Hồ
Chí Minh', '
<pre><h2>Ngày 1 - Vé máy bay khứ hồi + Phòng Deluxe + Ăn sáng</h2>
    Radisson Blu Resort Phu Quoc có khu vực bãi biển riêng và sòng bạc. Resort cách công viên động vật hoang dã (safari) và sân golf chưa đến 5 phút. Bao quanh chỗ nghỉ là khu vườn nhiệt đới cũng như sân hiên. Du khách có thể sử dụng Wi-Fi và xe đạp miễn phí trong suốt thời gian lưu trú. Tiện nghi lặn với ống thở và chèo thuyền kayak cũng được cung cấp miễn phí.
    
    Phòng nghỉ tại khách sạn có ban công riêng, TV màn hình phẳng và phòng tắm riêng. Mỗi phòng đều có tiện nghi pha trà/cà phê và tầm nhìn ra vườn hoặc hồ bơi ngoài trời trong khi các biệt thự hướng biển đi kèm hồ bơi riêng.
    
    Chỗ nghỉ phục vụ bữa sáng buffet hằng ngày. Nhà hàng Avenue Restaurant phục vụ ăn uống suốt cả ngày với đủ loại món ăn Việt Nam và quốc tế. Du khách có thể thưởng thức đồ uống giải khát và cocktail đặc trưng ở quầy bar tại sảnh Annex hoặc quầy bar ở hồ bơi Azure.
    
    Khu vực chăm sóc sức khỏe tại Radisson Blu Resort Phu Quoc có bể sục và phòng xông hơi khô. Du khách có thể lặn với ống thở tại bãi biển gần đó. Trung tâm thể dục của chỗ nghỉ mở cửa từ 06:00 đến 21:00. Du khách có thể chăm sóc bản thân tại spa có phòng xông hơi. Tại đây còn có tiệm làm đẹp và phòng tập yoga.
    
    Chỗ nghỉ nằm cách công viên giải trí Vinpearl Land Phú Quốc 5 phút đi bộ và sân bay quốc tế Phú Quốc 23 km. 
    
    Dịch vụ đưa đón miễn phí theo lịch trình đến và từ sân bay cũng được cung cấp cho du khách.
</pre>', 2990000, 1, 'on'),

('Phú Quốc - Thiên đường giải trí VinWonders - Vinpearl Safari', '2023-12-07', '2023-12-10', 'TP. Hồ Chí Minh', '
<pre><h2>Ngày 1 - TP HỒ CHÍ MINH - PHÚ QUỐC - SHOW DIỄN “SẮC MÀU VENICE” (Ăn chiều)</h2>
    Quý khách tập trung tại Sân bay Tân Sơn Nhất, ga đi trong nước. Hướng dẫn viên làm thủ tục cho Quý khách chuyến bay chiều phút đi Phú Quốc. Xe đón đoàn tại sân bay đưa về khách sạn nhận phòng nghỉ ngơi tại Phú Quốc.
    
    Buổi tối, Quý khách Thưởng thức bữa tiệc ánh sáng đỉnh cao với show diễn “Sắc màu Venice”
    <h2>Ngày 2 - VƯỜN THÚ BÁN HOANG DÃ VINPEARL SAFARI - VUI CHƠI THỎA THÍCH TẠI CÔNG VIÊN CHỦ ĐỀ VINWONDERS PHÚ QUỐC (Ăn sáng, trưa, chiều)</h2>
    Sau khi dùng bữa sáng, Quý khách sẽ đến khám phá Vinpearl Safari Phú Quốc - Vườn thú hoang dã đầu tiên tại Việt Nam: với quy mô 180 ha, hơn 130 loài động vật quý hiếm, du khách thưởng thức các chương trình biểu diễn, chụp ảnh với động vật; trải nghiệm vườn thú mở trong rừng tự nhiên, gần gũi và thân thiện với con người.
    
    Buổi chiều, Quý khách tham quan khu vui chơi giải trí VinWonders - công viên chủ đề lớn nhất Việt Nam, quy mô hàng đầu Châu Á, Quý khách khám phá
    - Trải nghiệm 12 nền văn minh nhân loại từ cổ chí kim;
    - Khám phá 06 phân khu công viên chủ đề với hơn 100 hoạt động giải trí siêu độc lạ;
    - Cuồng nhiệt tại công viên nước lớn nhất Đông Nam Á;
    - Chinh phục 20 trò chơi mạo hiểm khủng nhất hành tinh như đường trượt nhanh nhất thế giới “Cơn thịnh nộ của Zeus”, đường trượt khô “Cuộc chiến Chằn tinh” cao 15m đầu tiên của Việt Nam, đường trượt trong nhà tối “Chiến binh Đại bàng” và “Lời nguyền Ác long” - trò chơi tương tác trong nhà tối đầu tiên của Việt Nam,…
    - Choáng ngợp trước thế giới đại dương huyền ảo với tầm nhìn vô cực qua tấm kính acrylic khổng lồ 8x25m bên trong Cung điện Hải vương - thủy cung hình rùa lớn nhất thế giới; 
    - Ngỡ ngàng với show diễn triệu đô Once đẳng cấp thế giới. 
    <h3>Nghỉ đêm tại Phú Quốc.</h3>
    <h2>Ngày 3 - PHÚ QUỐC - GRAND WORLD - TP HỒ CHÍ MINH (Ăn sáng, trưa)</h2>
    Sau khi dùng bữa sáng, Quý khách trả phòng và khởi hành tham quan Grand World
    - Công viên Nghệ Thuật Đương Đại: sự giao thoa đặc sắc giữa nghệ thuật đương đại và thiên nhiên Đảo Ngọc.
    - Huyền thoại Tre: công trình tre lớn nhất Việt Nam.
    - Tản bộ bên dòng “kênh đào Venice” và nhìn ngắm những chiếc thuyền Gondola, khu phố shophouse lộng lẫy sắc màu, cổng lâu đài tráng lệ, ba cây cầu vòm bán nguyệt mang đậm kiến trúc châu Âu ...
    - Tham quan bảo tàng Gấu Teddy: lưu giữ nhiều hiện vật quý giá và tái hiện chuyến phiêu lưu hài hước của “nhà thám hiểm tài ba” Teddy Jones (chi phí tự túc)
    
    Đoàn tiếp tục hành trình tham quan:
    - Dinh Cậu: biểu tượng văn hoá và tín ngưỡng của đảo Phú Quốc. Nơi ngư dân địa phương gởi gắm niềm tin cho một chuyến ra khơi đánh bắt đầy ắp cá khi trở về. Sau đó, đoàn viếng Dinh Bà Thủy Long Thánh Mẫu - thờ Thần Nữ Kim Giao, người phụ nữ được người dân Phú Quốc rất mực tôn kính vì có công khai phá huyện đảo này.
    - Mua sắm đặc sản nổi tiếng tại nhà thùng nước mắm Hồng Đức 1, đặc sản Đức Thạnh, cơ sở sản xuất ngọc trai Phú Quốc - trưng bày các trang sức bằng ngọc trai chính hiệu được nuôi cấy tại Phú Quốc. 
    
    Xe đưa Quý khách ra sân bay Phú Quốc đáp chuyến bay trở về TP Hồ Chí Minh. Chia tay Quý khách và kết thúc chương trình du lịch tại sân bay Tân Sơn Nhất.
</pre>', 5390000, 9, 'on'),

('Phú Quốc - Trải nghiệm chèo Sup - Đạp xe tại Rạch Vẹm hoang sơ - Cắm trại đêm - BBQ tối', '2023-12-09', '2023-12-11',
'Phú Quốc', '
<pre><h2>Ngày 1 - CHÈO SUP - ĐẠP XE - RẠCH VẸM - CẮM TRẠI BÊN BỜ BIỂN (Ăn trưa, tối)</h2>
    08:00 Xe và Hướng dẫn viên đón đoàn tại trung tâm Dương Đông.

    08:20 Đoàn có mặt tại Sông Cửa Cạn - Một trong những con sông lớn nhất Phú Quốc.

    Quý khách nhận SUP, nghe hướng dẫn cách chèo SUP an toàn và đúng cách. Đoàn trải nghiệm chèo SUP trên đoạn đường dài khoảng 1km, ngắm cảnh 2 bên bờ sông vô cùng sống động.
    
    Đến điểm tập kết, xe và Hướng dẫn viên đưa Quý khách đến địa điểm nhận xe đạp và trải nghiệm đạp xe 5km khám phá cung đường xuyên rừng siêu đẹp đến Bãi Rạch Vẹm “Một bãi biển hoang sơ hiếm có trên đảo”.
    
    Quý khách trả xe đạp, nghỉ ngơi và giải khát nước dừa.
    
    11:00 Quý khách dùng cơm trưa, tắm biển và nghỉ ngơi tại Quán Sao Biển Rạch Vẹm.
    
    14:00 Xe đưa Quý khách đến khu bãi biển của Coco Garden Resort nhận lều, tiến hành sắp xếp và dựng lều.
    
    Buổi chiều, Quý khách có thể cùng nhau kéo lưới, bắt cá hoặc đi bắt ốc, nằm võng nghỉ ngơi tại bãi biển.
    
    Thưởng thức trái cây ngắm hoàng hôn và tự do tắm biển.
    
    18:00 Đoàn cùng nhau nướng BBQ với các món ăn đã được V Travel chuẩn bị sẵn như thịt, hải sản tươi ngon, tuyệt hảo. Giao lưu văn nghệ, ca hát với loa kéo được chuẩn bị sẵn.
    
    Khi những ngọn lửa trại được thắp lên, Quý khách quây quần bên ngọn lửa, chơi những trò chơi gắn kết tập thúc.
    
    Quý khách về lều của mình nghỉ ngơi (hoặc khách sạn)
    <h2>Ngày 2 - COCO GARDEN RESORT – TRUNG TÂM (Ăn sáng)</h2>
    Buổi Sáng Quý khách thức dậy tự do tập thể dục hoặc tự do tắm biển, nghỉ ngơi.
    
    07:30 Dùng điểm tâm sáng (mì gói hải sản, cà phê).
    
    09:00 Quý khách thu dọn hành lý chuẩn bị về lại khu trung tâm. 
    
    Xe và Hướng dẫn viên đưa Quý khách về điểm đón ban đầu. Kết thúc hành trình trải nghiệm đầy thú vị. 
    
    Hẹn gặp lại Quý khách.
</pre>', 2700000, 10, 'on'),

('Đà Lạt – Khu Du lịch Chuồn Chuồn – Thung Lũng Tình Yêu – Mongo Land - Vườn Bonsai Hoàng Long Ohayo', '2023-12-05',
'2023-12-09', 'TP. Hồ Chí Minh', '
<pre><h2>Ngày 1 - TP. HỒ CHÍ MINH – KDL CHUỒN CHUỒN – LINH ẨN TỰ - ĐÀ LẠT Số bữa ăn: 03 bữa (Sáng, Trưa, Chiều)</h2>
    Quý khách tập trung tại V Travel (190 Pasteur, P. Võ Thị Sáu, Q3, TP.HCM), khởi hành đi Đà Lạt. Đoàn dùng bữa sáng và bữa trưa trên đường đi.
    
    Trên hành trình đến với thành phố sương mù, xe và HDV đưa khách đi trên cung đường QL27 nối vào DT725 chinh phục đèo Tà Nung một trong những trục đường dẫn vào thành phố Đà Lạt. Đoàn dừng chân tham quan: 
    
    - Chùa Linh Ẩn: được xây dựng theo thế lưng tựa núi mặt hướng thủy với rừng thông bạt ngàn bao quanh và trước mặt là thác Voi hùng vĩ. Nơi đây mang lối kiến trúc cổ kính, đem đến không gian bình yên, thanh tịnh tại chốn thiên môn cho Quý khách. Ngôi chùa còn nổi tiếng với Bức tượng Quan Thế Âm cao nhất Việt Nam.
    
    - KDL Chuồn Chuồn: điểm đến mới tại xã Mê Linh, đến đây du khách thỏa thích tạo dáng tại hồ cô cực, hồ chuồn chuồn, thác vọng cảnh và nhiều tiểu cảnh lớn nhỏ khác. Chiêm ngưỡng hàng trăm loài hoa đặc sắc của Đà Lạt. Thưởng thức cà phê chất lượng cao hay những thức uống thơm ngon đa dạng (chi phí nước uống tự túc).
    
    Chiều đoàn tiếp tục hành trình về Đà Lạt, nhận phòng nghỉ ngơi. Buổi tối, Quý khách tự do thưởng thức café ngắm hồ Xuân Hương về đêm
    <h3>Nghỉ đêm tại Đà Lạt.</h3>
    <h2>Ngày 2 - ĐÀ LẠT - KHÁM PHÁ THUNG LŨNG TÌNH YÊU – CẦU KÍNH NGÀN THÔNG 7D Số bữa ăn: 02 bữa (Sáng, Trưa, Ăn chiều tự túc)</h2>
    Quý khách dùng bữa sáng tại khách sạn, xe đưa đoàn đi tham quan:
    
    - Khám phá Thung Lũng Tình Yêu – Đồi Mộng Mơ: đến đây du khách như lạc vào không gian cổ tích với nhiều hoạt động thú vị như:
    
    + Khám phá như mê cung tình yêu hình trái tim màu xanh trải rộng trên diện tích 4.000m², thung lũng ngàn hoa, công trình 30 kỳ quan, bảo tàng tượng sáp… 
    
    + Check-in các không gian sắc màu của dãy phố cổ Hội An, vườn hoa lavender, cây tình yêu, cầu thang sách, đồi vọng cảnh. 
    
    + Chinh phục Cầu Kính Ngàn Thông 7D – là cây cầu kính thứ 4 tại Việt Nam và là đầu tiên của khu vực Miền Trung – Tây Nguyên. Nằm ở độ cao 1500m, cầu kính hứa hẹn sẽ là một địa điểm sống ảo và mang lại nhiều cảm xúc mới lạ cho quý khách. (chi phí cầu kính tự túc)
    
    + Tham qua các hoạt động như: đạp vịt, Pedalo trên hồ Đa Thiện, khu trò chơi liên hoàn với các trò chơi như: giữ thăng bằng trên dây cáp (highwire); đu dây mạo hiểm tự do (zipline)... và xe điện tham quan Thung Lũng Tình Yêu.
    
    Sau bữa trưa, đoàn dừng chân mua sắm đặc sản làm quà cho người thân, bạn bè và trở về khách sạn nghỉ ngơi, tự do khám phá thành phố sương mù. 
    
    - Mua sắm đặc sản Đà Lạt tại cơ sở mứt Thanh Nhu: các loại trái cây sấy giòn, sấy dẻo, nước cốt dâu tằm – dâu tươi, trà atiso, trà hoa, ...
     
    Buổi tối, đoàn nghỉ ngơi tại khách sạn hoặc tự do khám phá Thành phố Đà Lạt:
    
    - Vào 16h30 đón hoàng hôn và thưởng thức bữa tiệc âm nhạc cùng Amazing Show với không gian ngoài trời và có tầm nhìn xuống thành phố Đà Lạt thơ mộng. Hoặc vào 19h00 thưởng thức những bản nhạc trữ tình xưa, nhạc Trịnh, nhạc Bolero tại ‘‘Âm sắc Đà Lạt – Cung Đàn Xưa’’, Quý khách có dịp trải nghiệm một phong cách sống “chậm” và tận hưởng từng phút giây, lưu giữ những khoảnh khắc tuyệt vời ở tận sâu trong tâm hồn mỗi người. (Chi phí tự túc)
    
    - Trải nghiệm tắm khoáng nóng & xông hơi tại Dlat’s giúp bạn thư giãn và nghỉ ngơi, giải tỏa căng thẳng (Chi phí tự túc)
    
    ***Lưu ý: Chi phí vé và đi lại tự túc***
    
    Buổi tối, Quý khách tự do tản bộ Chợ Đà Lạt. 
    <h3>Nghỉ đêm tại Đà Lạt.</h3>
    <h2>Ngày 3 - ĐÀ LẠT – MONGO LAND - NHÀ THỜ DOMAIN DE MARIE – THIỀN VIỆN TRÚC LÂM Số bữa ăn: 03 bữa (Sáng, Trưa, Chiều)</h2>
    Quý khách dùng bữa sáng tại khách sạn, xe cùng hướng dẫn viên của V Travel đưa đoàn di chuyển đến tham quan:
    
    - Mongo Land: mang vẻ đẹp hoàn toàn mới lạ - một ""tiểu Mông Cổ thu nhỏ"" trong lòng Đà Lạt được thiết kế như một nông trại với những chiếc lều đủ màu sắc. Tất cả đều được bài trí độc đáo, bắt mắt theo phong cách Mông Cổ đặc trưng. Đến đây, ngoài việc tận hưởng bầu không khí trong lành và chiêm ngưỡng vẻ đẹp của thiên nhiên hùng vĩ, Quý khách sẽ được trải nghiêm: 
   
    + Thỏa thích chụp ảnh tại lều mông cổ, xích đu, nông trại âu, thảm cỏ, sa mạc xương rồng,…
   
    + Hòa mình vào thế giới của động vật: hươu sao, dê mini, cừu, thỏ Việt, thỏ Holland Lop Hà Lan, thỏ Sư Tử, chim Yến, Chinchilla, sóc Chipmunk,… và tự tay cho thú ăn (thức ăn sẽ được Mongo Land chuẩn bị sẵn cho quý khách).
   
    + Trải nghiệm cảm giác “siêu đã” tại đường trượt phao khô đẹp và dài nhất Đà Lạt
   
    + Tham gia các hoạt động vui chơi như: trượt cỏ, bắn cung
   
    + Trở thành những cô nàng, chàng trai du mục thực thụ khi diện trên mình trang phục người Mông Cổ. (Chi phí thuê trang phục tự túc).
    
    Buổi trưa, đoàn dùng bữa trưa tại nhà hàng địa phương. Sau đó tiếp tục tham quan:
    
    - Nhà Thờ Domain de Marie: theo dòng nữ tu Bác Ái, tọa lạc trên đồi Mai Anh, nổi bật với màu hồng sáng rực. Quý khách có thể chọn cho mình những món đồ từ len trong khuôn viên phía sau nhà thờ.
    
    - Thiền viện Trúc Lâm: với quần thể công trình kiến trúc độc đáo, du khách còn được ngắm nhìn các vườn hoa xinh đẹp khoe sắc và toàn cảnh Hồ Tuyền Lâm với thiên nhiên, núi đồi, rừng thông Đà Lạt. 
    
    Sau bữa tối, đoàn tự do uống café quanh khu vực Hồ Xuân Hương hay thưởng thức ly sữa đậu nành nóng hổi, bánh tráng nướng đặc sản Đà Lạt khu vực Tăng Bạt Hổ.  
    <h3>Nghỉ đêm tại Đà Lạt.</h3>
    <h2>Ngày 4 - ĐÀ LẠT – HOÀNG LONG OHAYO - TP. HỒ CHÍ MINH Số bữa ăn: 02 bữa (Sáng, Trưa)</h2>
    Quý khách dùng bữa sáng tại khách sạn và làm thủ tục trả phòng, hướng dẫn viên đưa đoàn đi tham quan:
    
    - Hoàng Long Ohayo: tự hào là một trong những khu vườn bonsai lá kim lớn nhất Việt Nam với những chậu cây bonsai được chăm sóc và uốn nắn kỹ lưỡng vô cùng đẹp mắt. Ngoài ra, quý khách còn được chiêm ngưỡng những loài hoa nổi tiếng của Đà Lạt, hồ cá Koi đặt tiêu chuẩn Nhật Bản, hàng loạt tiểu cảnh mang đậm sắc màu Nhật Bản như hàng cổng Tori, khu thác nước, khu phố Nhật, con đường tre,… Tất cả sẽ tạo nên một không gian thư thái hoà quyện với thiên nhiên. 
    
    Đoàn khởi hành về TP. HCM và dừng tại Bảo Lộc dùng cơm trưa, sau đó khởi hành về điểm đón ban đầu. Chia tay đoàn và kết thúc chương trình du lịch.
</pre>', 3790000, 6, 'on');

-- Example data for account
INSERT INTO account(username, password, fullname, email, phone_number, role, status)
VALUES ('admin', 'admin', 'ADMIN', 'admin@gmail.com', 0123456789, 'admin', 'on'),
	('user', 'user', 'USER', 'user@gmail.com', 0112233445, 'user', 'on'),
	('linh', 'linh', 'Danh Linh', 'linh@gmail.com', 0231574839, 'user', 'on'),
    ('son', 'son', 'Hoàng Sơn', 'son@gmail.com', 0127583647, 'user', 'on'),
    ('hoan', 'hoan', 'Nguyễn Hoàn', 'hoan@gmail.com', 0942637482, 'user', 'on'),
    ('hoang', 'hoang', 'Việt Hoàng', 'hoang@gmail.com', 0857364237, 'user', 'on'),
    ('dat', 'dat', 'Mạnh Đạt', 'dat@gmail.com', 0768543782, 'user', 'on'),
    ('theanh', 'theanh', 'Thế Anh', 'theanh@gmail.com', 0683948389, 'user', 'on');
    
-- Example data for post 
INSERT INTO post(user_id, post_name, short_description, content, post_date)
VALUES (3, "Kinh nghiệm du lịch Hà Nội", "Thành phố Hà Nội là Thủ đô ngàn năm văn hiến với những di tích cổ xưa, cuộc sống yên bình.
Nếu đã một lần du lịch Hà Nội, chắc chắn bạn không thể nào quên không khí đặc trưng nơi đây, với Hồ Gươm, Hồ Tây, những
quán cafe trầm mặc, những con đường nhỏ và những gánh hàng rong.","
<pre>
    <h1>Kinh nghiệm du lịch Hà Nội</h1>
    Thành phố Hà Nội là Thủ đô ngàn năm văn hiến với những di tích cổ xưa, cuộc sống yên bình. Nếu đã một lần du lịch Hà
    Nội, chắc chắn bạn không thể nào quên không khí đặc trưng nơi đây, với Hồ Gươm, Hồ Tây, những quán cafe trầm mặc,
    những con đường nhỏ và những gánh hàng rong.

    <h3>Phương tiện đi lại</h3>
    Từ TP.HCM, Đà Nẵng hay Cần Thơ thì phương tiện thuận tiện và tiết kiệm thời gian nhất bạn nên chọn là máy bay, bởi
    hiện nay các hãng hàng không Vietjet, Jestar hay Vietnam Airlines luôn có nhiều chương trình khuyến mãi hấp dẫn, bạn
    nên đăng ký địa chỉ mail để các hãng hàng không gởi thông tin khuyến mãi nhé. Ngoài ra, bạn có thể chọn xe lửa tàu
    Thống Nhất Bắc Nam tuy nhiên lưu ý bạn chỉ nên chọn khi có nhiều thời gian tham quan.

    Từ sân bay Nội Bài về trung tâm khoảng 30km, bạn có thể đi taxi nếu đi đông hay chọn xe bus trung chuyển của hai
    hãng hàng không nội địa là Jetstar và VietJet Air với giá mềm hơn. Trong trung tâm Hà Nội để tham quan bạn nên thuê
    xe máy để di chuyển, ngoài ra còn 2 phương tiện cũng khá độc đáo để thăm thủ đô là xích lô và xe điện.
    Nên đi Hà Nội mùa nào?
    Thời gian thích hợp nhất để du lịch Hà Nội là vào tháng 9 đến tháng 11 hoặc từ tháng 3 đến tháng 4, đó là lúc chuyển
    mùa thời tiết ấm áp và dễ chịu, không quá nắng gắt hay hanh khô. Tuyệt vời nhất là vào mùa thu, Hà Nội như khoác một
    chiếc áo mới, dịu dàng và lãng mạng nhất trong năm.
    Những điểm nào nên tham quan khi đến Hà Nội
    Hà Nội có rất nhiều điểm tham quan di tích lịch sử - văn hóa để bạn tham quan tìm hiểu, ngay khu vực trung tâm thủ
    đô bạn hãy ghé tham quan Hồ Hoàn Kiếm, ngắm tháp Rùa, đền Ngọc Sơn, cầu Thê Húc. Chiêm ngưỡng và chụp hình tại Nhà
    thờ lớn Hà Nội, Nhà hát lớn Hà Nội, khu phố Cổ. Xa hơn một chút tầm 3km bạn hãy viếng Lăng Bác (lưu ý Lăng không mở
    thứ 2, 6 hàng tuần) thăm quan Bảo tàng Hồ Chí Minh, nhà sàn Bác Hồ, chùa Một Cột, quảng trường Ba Đình; tiếp tục
    tham quan Văn Miếu - Quốc Tử Giám - nơi thờ Khổng Tử và các bậc hiền triết của Nho Giáo, Hoàng Thành Thăng Long.

    Ngày hôm sau tại Hà Nội bạn hãy ghé khu vực Hồ Tây, tham quan Đền Quán Thánh, chùa Trấn Quốc. Thích tìm hiểu về văn
    hóa các dân tộc thì bạn ghé tham quan Bảo tàng dân tộc học Việt Nam, nếu còn thời gian tại Hà Nội bạn hãy ghé các
    khu vực lân cận như làng gốm Bát Tràng (cách trung tâm 20km), làng cổ Đường Lâm (cách trung tâm 45km) nơi còn lưu
    giữ những nét cổ xưa của một làng quê miền Bắc.
    <h3>Hà Nội có lễ hội gì đặc sắc?</h3>
    Lễ hội Chùa Hương là lễ hội đặc sắc nhất ở Hà Nội, được diễn ra từ mùng 6 tháng Giêng đến hết tháng 3 âm lịch, tuy
    nhiên trong giai đoạn lễ hội thường rất đông nên bạn có thể đi dịp trước tết dương lịch và nguyên đán. Ngoài ra, Hà
    Nội còn có các lễ hội như Hội gò Đống Đa mùng 5 Tết tại gò Đống Đa, lễ hội đền Gióng Sóc Sơn ngày 6/1 âm lịch, lễ
    hội Cổ Loa diễn ra từ ngày 6 đến 16 tháng giêng âm lịch (chính hội ngày 6).
    Khách sạn và ẩm thực địa phương
    Hà nội có rất nhiều khách sạn để bạn lựa chọn, để tham khảo các khách sạn hợp với túi tiền và vị trí gần trung tâm
    phố cổ bạn nên tham khảo trước trên các web tư vấn khách sạn như Agoda hay Tripadvisor rất hữu ích. Ngoài ra, mình
    tư vấn cho bạn một số khách sạn như Asian Star, Chaerry 2, Crysral 2 sao hay khách sạn 3 sao như Boss, ATS, Church
    Boutique.

    Ẩm thực Hà Nội luôn hấp dẫn với những món ăn đậm chất riêng. Một số món ăn không thể bỏ qua khi du lịch Hà Nội: phở
    gánh Hàng Trống, chả cá Lã Vọng, bún chả, bún thang, bánh cốm, bánh cuốn, bún đậu mắm tôm.
    <h3>Đến Hà Nội mua gì về làm quà?</h3>
    Hà Nội có khá nhiều sản phẩm để bạn mua về làm quà cho người thân như các sản phẩm sơn mài, thủ công, đồ lưu niệm
    như đồ trang trí bằng bạc, gốm sứ và đồ trang sức dọc phố Hàng Khay, Tràng Tiền; sản phẩm lụa cũng khá đẹp bạn có
    thể mua tại phố Hàng Gai, phố Nha Thờ. Ngoài ra, các đặc sản mua về ăn như Ô Mai (hàng Đường), bánh cốm (Hàng Than)
    hay bánh đậu xanh (hàng Điếu) rất được du khách ưu chuộng khi mua về.
    <h3>Những điều lưu ý</h3>
    Miền Bắc có bốn mùa rõ rệt trong năm, chính vì vậy thời tiết là điều bạn cần quan tâm khi đi du lịch Hà Nội. Mùa hè
    trời thường rất nắng nóng, mùa đông thì rất lạnh, mùa xuân thì hay mưa phùn, ẩm ướt. Hãy có một tấm bản đồ để xác
    định quãng đường đi, tránh việc bị người khác (xe ôm, taxi) đưa đi lòng vòng rồi tính tiền. Hãy hỏi về giá cả trước
    khi sử dụng bất cứ dịch vụ nào. Cách tốt nhất là bạn nên nhờ lễ tân tại khách sạn mình ở tư vấn, giúp đỡ khi cần
    thông tin. Để thưởng thức hết vẻ đẹp thiên nhiên, kiến trúc kỳ vĩ ở các chùa lớn thì không nên đi các chùa vào mùa
    lễ hội.
    </pre>", "2023-12-14 12:32:40"),
    (4, "Kinh nghiệm du lịch Hạ Long", "Hạ Long là điểm đến du lịch bạn nên đến một lần trong đời, bởi ngoài thưởng ngoạn phong
cảnh thiên nhiên tuyệt đẹp của Vịnh Hạ Long cùng với hệ thống các hang động, bạn còn trải nghiệm những hoạt động như ngủ
đêm trên du thuyền, chèo kayak, tham quan những điểm đến linh thiêng như Yên Tử, Chùa Ba Vàng và không thể cưỡng lại với
những món ăn làm mê hoặc lòng người như chả mực, hàu nướng, sá sùng…","
<pre>
    <h1>Kinh nghiệm du lịch Hạ Long</h1>
    Hạ Long là điểm đến du lịch bạn nên đến một lần trong đời, bởi ngoài thưởng ngoạn phong cảnh thiên nhiên tuyệt đẹp
    của Vịnh Hạ Long cùng với hệ thống các hang động, bạn còn trải nghiệm những hoạt động như ngủ đêm trên du thuyền,
    chèo kayak, tham quan những điểm đến linh thiêng như Yên Tử, Chùa Ba Vàng và không thể cưỡng lại với những món ăn
    làm mê hoặc lòng người như chả mực, hàu nướng, sá sùng…

    <h3>Phương tiện đi lại</h3>
    Hạ Long cách Hà Nội khoảng 150km, bạn có thể ra bến xe Lương Yên, Mỹ Đình để bắt xe đi Hạ Long, có nhiều nhà xe và
    chạy liên tục trong ngày, xe chạy khoảng 4 tiếng. Với những chuyến đi 2 ngày 1 đêm với dịch vụ ngủ đêm trên du
    thuyền thì bạn an tâm là du thuyền đón bạn tại khách sạn nên sẽ không lo vận chuyển xuống Hạ Long. Từ miền Trung hay
    miền Nam đến Hạ Long thì bạn có thể lựa chọn bay trực tiếp đến Hà Nội hoặc Hải Phòng sau đó bắt xe đi Hạ Long, riêng
    miền Tây thì chỉ có bay trực tiếp đến Hà Nội thôi nhé.
    <h3>Nên đi Hạ Long mùa nào?</h3>
    Thời điểm tốt nhất để tham quan Hạ Long là vào mùa hè (tháng 4 – 10), lưu ý tháng 6 – 7 thường có mưa bão nên hạn
    chế thời gian này. Mùa đông ở Hạ Long rất lạnh (tháng 11 – 3 năm sau), nên bạn lưu ý mang theo áo ấm nhé.
    <h3>Những điểm nào nên tham quan khi đến Hạ Long</h3>
    Trên đường ra Hạ Long nếu đi bằng xe máy bạn có thể ghé tham quan núi Yên Tử, cách thành phố Hạ Long 73km, núi Yên
    Tử khá rộng và phải di chuyển bằng cáp treo 2 lượt nên nếu tham quan cả Chùa Đồng bạn sẽ mất một ngày. Chiều trên
    đường về Hạ Long bạn tiếp tục ghé tham quan Chùa Ba Vàng, cách Yên Tử 35km và cách Hạ Long 40km. Ngày hôm sau bắt
    đầu chuyến hành trình khám phá Vịnh bạn có thể lựa chọn tuyến tham quan Động Thiên Cung và Hang Dấu Gỗ (4 tiếng)
    hoặc Hang Sửng Sốt và Đảo Ti Tốp (6 tiếng), trên đường đi bạn sẽ được nhìn thấy Hòn Đỉnh Hương, Hòn Gà Chọi…

    Nếu còn thời gian tại Hạ Long bạn có thể ghé tham quan Làng chải Cửa Vạn để tìm hiểu cuộc sống của ngư dân miền biển
    và tham gia vào những cuộc đánh bắt cá, câu cá, mực, chèo thuyền với ngư dân. Muốn tắm biển thì ghé đảo Ti Tốp, biển
    Tuần Châu hay Bãi Cháy. Hay tìm hiểu về di tích lịch sử Hạ Long thì bạn nên ghé núi Bài Thơ, đền thờ Trần Quốc
    Nghiễm, chùa Cửa Ông, bảo tàng Quảng Ninh. Ngoài ra, Đảo Cô Tô cũng là một điểm đến thú vị mà du khách Hà Nội thường
    lựa chọn vào dịp hè (cách Hạ Long 60km), đảo hiện tại vẫn còn giữ nét hoang sơ nên biển rất xanh và êm ả.
    <h3>Hạ Long có lễ hội gì đặc sắc?</h3>
    Lễ Hội đặc sắc nhất tại Hạ Long mà du khách hay quan tâm là Carnaval Hạ Long thường tổ chức định kỳ tháng 4 hàng năm
    tại Quảng Trường thành phố Hạ Long. Trong tháng 4 còn có lễ hội Hoa Anh Đào Hạ Long với hàng trăm cành đào đến từ
    Nhật Bản. Ngoài ra, tại Hạ Long còn có lễ hội Yên Tử được tổ chức thường niên, bắt đầu từ ngày 10 tháng giêng và kéo
    dài hết tháng 3 (âm lịch), lễ hội Đền Cửa Ông diễn ra từ 2/1 – 30/3 âm lịch, lễ hội Bạch Đằng được tổ chức vào ngày
    mùng 8 tháng 3 (âm lịch) hàng năm.
    <h3>Khách sạn và ẩm thực tại địa phương</h3>
    Hạ Long được phân ra làm 2 khu: Hòn Gai và Bãi Cháy, được nối với nhau bởi cây cầu Bãi Cháy. Khu du lịch chính là
    Bãi Cháy, với bờ biển chạy dài và các cảng du lịch. Khu Hòn Gai là khu trung tâm hành chính. Bạn nên ở khu Bãi Cháy
    cho thuận tiện đi lại và ăn uống. Tại Bãi Cháy có rất nhiều khách sạn để bạn lựa chọn, trước khi quyết định đặt
    khách sạn nào bạn nên tham khảo đánh giá của các khách ở trước trên web Agoda hay Tripadviser để có thêm thông tin
    tham khảo. Một vài khách sạn gợi ý cho bạn các khách sạn 3 sao như Blue Sky, BMC Thăng Long, Golden Lotus, City Bay
    Palace. Ngoài ra, bạn nên trải nghiệm một đêm trên du thuyền Hạ Long sẽ rất thú vị, các du thuyền mình hay ngủ đêm
    như Bài Thơ, Pelican, Halong Emotion.

    Hạ Long là thiên đường của hải sản nên đến đây bạn không nên bỏ qua món chả Mực, hàu nướng, Sam xào chua ngọt, Sá
    Sùng, bún tôm, bún xào Ngán, tu hài Vân Đồn. Ngoài ra các món nem chua và canh hà Quảng Yên Cà Sáy (vịt lai nga)
    cũng rất hấp dẫn.
    <h3>Đến Hạ Long mua gì về làm quà?</h3>
    Hạ Long có khá nhiều mặt hàng để bạn mua về làm quà cho người thân như đồ hải sản gồm mực khô, sá sùng khô, chả mực
    được bán nhiều tại các chợ Cái Dăm, chợ Hạ Long 1, Hạ Long 2. Đồ lưu niệm được chế tác từ vỏ sinh vật biển, than đá,
    gỗ, khảm trai, ngọc trai, các sản phẩm này bạn có thể mua tại cửa hàng lưu niệm Hòn Gai hoặc chợ đêm Hạ Long. Ngoài
    ra, còn có rượu Ngán Hạ long nem chua Quảng Yên, Cà sáy (vịt lai ngan) bạn có thể mua về để cả gia đình cùng thưởng
    thức.
    <h3>Những điều lưu ý</h3>
    Mua hàng tại Hạ Long thì bạn lưu ý dò hỏi giá ở nhiều cửa hàng để so sánh trước khi quyết định mua vì đa số các cửa
    hàng đều nói thách. Khi ngủ đêm trên du thuyền lưu ý giữ gìn vệ sinh cảnh quan môi trường biển. Nếu đi đảo Cô Tô bạn
    nên tránh lúc thời tiết gió bão vì tàu thuyền sẽ không được phép chạy nếu sóng quá lớn.
    </pre>", "2023-12-14 15:40:03"),
    (5, "Kinh nghiệm du lịch Ninh Bình", "Ninh Bình là một trong ba điểm đến hấp dẫn nhất ở miền Bắc (sau Hạ Long và Sa Pa), bởi
nơi đây có nhiều thắng cảnh hùng vĩ và tráng lệ, đó là các danh thắng đất ngập nước Tràng An, Tam Cốc, Vân Long hay
những công trình kiến trúc đẹp và đồ sộ như Chùa Bái Đính, nhà thờ Phát Diệm, Cố Đô Hoa Lư và vườn quốc gia Cúc Phương
dành cho những ai thích thiên nhiên và khám phá. Vùng đất Ninh Bình còn nổi tiếng với nhiều danh nhân đất Việt tiêu biểu
như anh hùng dân tộc Đinh Bộ Lĩnh, Lê Hoàn, Lê Đại Hành,", "
<pre>
    <h1>Kinh nghiệm du lịch Ninh Bình</h1>
    Ninh Bình là một trong ba điểm đến hấp dẫn nhất ở miền Bắc (sau Hạ Long và Sa Pa), bởi nơi đây có nhiều thắng cảnh
    hùng vĩ và tráng lệ, đó là các danh thắng đất ngập nước Tràng An, Tam Cốc, Vân Long hay những công trình kiến trúc
    đẹp và đồ sộ như Chùa Bái Đính, nhà thờ Phát Diệm, Cố Đô Hoa Lư và vườn quốc gia Cúc Phương dành cho những ai thích
    thiên nhiên và khám phá. Vùng đất Ninh Bình còn nổi tiếng với nhiều danh nhân đất Việt tiêu biểu như anh hùng dân
    tộc Đinh Bộ Lĩnh, Lê Hoàn, Lê Đại Hành,

    <h3>Phương tiện đi lại</h3>
    Cách Hà Nội chỉ 100km nên bạn có thể tham quan Ninh Bình bằng xe máy hoặc xe khách, nhưng mình khuyên bạn nên đi xe
    khách vì thuận tiện và sức khỏe. Các bến xe khách đi Ninh Bình đó là Giáp Bát và Mỹ Đình, hàng ngày đều có các
    chuyến xe khách Bắc Nam chạy liên tục. Nếu đi Open Bus bạn có thể đi của hãng The Sinh Tourist hoặc Hưng Thành. Vì
    các điểm tham quan ở Ninh Bình cách xa nhau nên đến Ninh Bình bạn nên thuê xe máy để thuận tiện di chuyển. Các bạn
    từ TP.HCM, miền Tây hay miền Trung thì nên đặt vé máy bay giá rẻ để đến Hà Nội trước, sau đó kết hợp tham quan Ninh
    Bình.
    <h3>Nên đi Ninh Bình mùa nào?</h3>
    Nếu muốn đi viếng chùa Bái Đính thì nên đến vào những ngày đầu năm (từ mùng 6 đến tháng 3 âm lịch), còn đam mê chụp
    ảnh mùa vàng Tam Cốc thì bạn nên đến vào tháng 5 – 6.
    Những điểm nào nên tham quan khi đến Ninh Bình
    Để tham quan hết các điểm đặc sắc tại Ninh Bình bạn mất 2 – 3 ngày. Ngày đầu tiên đến Ninh Bình bạn hãy ghé thăm
    Chùa Bái Đính và Khu du lịch Tràng An – di sản thiên nhiên và địa chất thế giới, Tràng An khá rộng nên mất khoảng 3
    tiếng ngồi thuyền, các hang động tại Tràng An khá dài và rộng hang Hang Cả, Hang Hai, Hang Ba.

    Ngày thứ 2 tại Ninh Bình bạn hãy ghé thăm nhà thờ Phát Diệm cách trung tâm Ninh Bình 30km, trưa về ghé tham quan Cố
    Đô Hoa Lư – đền thờ vua Đinh, vua Lê. Ngoài ra nếu còn thời gian tại Ninh Bình bạn hãy ghé tham quan Tam Cốc, hệ
    thống hang động ít và ngắn hơn Tràng An nhưng tuyệt đẹp vào mùa lúa (tháng 5 – 6), chùa Bích Động (cùng hướng Tam
    Cốc). Khu bảo tồn thiên nhiên Vân Long - khu bảo tồn thiên nhiên ngập nước lớn nhất đồng bằng Bắc Bộ, tại đây còn có
    suối nước nóng Kênh Gà, động Vân Trình, Kẽm Trống và nhiều núi hang đẹp khác. Ngoài ra còn có động Thiên Hà và Vườn
    Quốc Gia Cúc Phương cho những yêu thiên nhiên và khám phá.
    <h3>Ninh Bình có lễ hội gì đặc sắc</h3>
    Nếu đến vào dịp đầu năm bạn sẽ tham quan Lễ hội chùa Bái Đính là một lễ hội xuân được tổ chức hàng năm, diễn ra từ
    ngày mùng 6 Tết đến hết tháng 3 âm lịch. Ngoài ra trong tháng 3 (mồng 10 tháng 3 âm lịch) còn có lễ hội Hoa Lư,
    tương truyền là ngày vua Đinh lên ngôi hoàng đế, nhân dân Trường Yên lại mở hội tưởng nhớ Đinh Tiên Hoàng.
    <h3>Khách sạn và ẩm thực địa phương</h3>
    Trước khi quyết định đặt phòng bạn hãy tham khảo thêm các đánh giá của những người từng ở trước trên các trang web
    như Agoda hay Tripadvisor để lựa chọn khách sạn mình thích và hợp túi tiền. Một số khách sạn gợi ý mình đánh giá tốt
    như Tuấn Ngọc 1 sao, Canh Dieu Moutain, Ngọc Anh & Kinh Đô 2 sao, còn 3 sao thì có Bái Đính và khách sạn Queen.

    Nhắc đến Ninh Bình là nhắc đến dê núi, vì vậy bạn không quên thưởng thức món dê núi (được chế biến gần 20 món) ăn
    kèm cơm cháy, ngoài ra còn có những món đặc sắc như gỏi cá nhệch Kim Sơn, ốc núi, nem Yên Mạc, canh chua cá rô, miến
    lươn chắc chắc sẽ làm bạn hài lòng.
    <h3>Đến Ninh Bình mua gì về làm quà?</h3>
    Gợi ý một số sản vật Ninh Bình bạn có thể mua về là quà cho người thân là rượu cần Nho Quan, hàng mỹ nghệ từ cói
    Ninh Bình (như thảm, khay, túi xách, cốc, mũ) và món ăn đặc sản cơm cháy chà bông.
    <h3>Những điều lưu ý</h3>
    Mùa mưa ở Ninh Bình từ tháng 5 – tháng 9 nên bạn nhớ mang theo dù khi đi du lịch, còn mùa đông (tháng 12 – tháng 1)
    thì nên mang theo áo ấm vì mua đông miền Bắc khá lạnh và buốt.
    </pre>", "2023-12-10 20:30:00"),
    (6, "Kinh nghiệm du lịch Huế", "Thành phố Huế nằm trên dải đất miền Trung được biết đến với Quần thể Di tích Cố đô Huế - Di
sản Văn hóa Thế giới và Nhã nhạc Cung đình Huế - Kiệt tác phi vật thể và truyền miệng của nhân loại. Ngoài ra, Huế còn
nổi tiếng với những lăng tẩm, món ăn ngon và làng nghề truyền thống lâu đầu.", "
<pre>
    <h1>Kinh nghiệm du lịch Huế</h1>
    Thành phố Huế nằm trên dải đất miền Trung được biết đến với Quần thể Di tích Cố đô Huế - Di sản Văn hóa Thế giới và
    Nhã nhạc Cung đình Huế - Kiệt tác phi vật thể và truyền miệng của nhân loại. Ngoài ra, Huế còn nổi tiếng với những
    lăng tẩm, món ăn ngon và làng nghề truyền thống lâu đầu.

    <h3>Phương tiện đi lại</h3>
    Để đến Huế bạn có thể lựa chọn nhiều phương tiện như xa khách, tàu hỏa, máy bay. Nhưng tốt nhất mình khuyên bạn nên
    chọn máy bay để tiết kiếm thời gian nếu di chuyển từ TP.HCM và Hà Nội, và vì các hãng hàng không của Việt Nam
    (Vietjet, Jestar, Vietnam Airlines) thường có nhiều chương trình khuyến mãi, bạn lưu ý đăng ký mail để có thông tin
    khuyến mãi của hàng không. Còn từ Cần Thơ bạn nên bay trực tiếp đến Đà Nẵng, sau đó kết hợp chuyến hành trình tham
    quan Huế, chỉ cách 100km.

    Tại thành phố Huế thì bạn nên lựa chọn phượng tiện phổ biến là thuê xe máy dể dạo quanh phố phường, bạn có thể dễ
    dàng thuê tại các khách sạn mình ở. Ngoài ra, bạn có thể thuê xích lô tham quan cố đô và trong khu Đại Nội Huế cũng
    rất thú vị.
    <h3>Nên đi Huế mùa nào?</h3>
    Bạn nên đến Huế vào mùa khô từ tháng 3 – tháng 8, có khi nhiệt độ lên tới 35-400C tuy nhiên đây là mùa khô ráo nên
    bạn có thể tham quan và khám phá trọn vẹn cố đô Huế. Ngoài ra, để hiểu về bản sắc văn hóa Huế bạn nên đến vào dịp
    Festival Huế (được tổ chức 2 năm 1 lần vào các năm chẵn vào cuối dịp tháng 4.
    <h3>Những điểm nào nên tham quan khi đến Huế</h3>
    Ngày đầu đến Huế bạn nên ghé tham quan Hoàng Cung Huế, cách trung tâm tầm 6km, điểm tham quan này khá rộng nên mất
    gần 1 buổi, tại đây có lễ đổi gác từ 9h00 – 9h30 hàng ngày nên bạn chú ý xem để biết hoạt động đổi gác ngày xưa dưới
    thời vua chúa như thế nào nhé. Nếu còn thời gian buổi sáng bạn có thể ghé tham quan Chùa Thiên Mụ, cách Hoàng Cung
    Huế 6km. Buổi chiều thì bạn nên tham quan lăng của các vua Triều Nguyễn như Minh Mạng, Tự Đức, Khải Định, Gia Long,
    Thiệu Trị, Đồng Khánh trong phạm vị bán kính tầm 7 – 12km.

    Nếu còn thời gian ở lại Huế bạn có thể đi thuyền trên sông Hương tham quan ghé Điện Hòn Chén, làng hoa giấy Thanh
    Tiên. Tắm biển Thuận An cách trung tâm Huế 18km, ghé Phá Tam Giang ngắm hoàng hôn hay thư giãn tại Suối khoáng nóng
    Thanh Tân (cách Huế 31km). Buổi tối ở Huế bạn hãy đi thuyền trên sông Hương, thả đèn hoa đăng và thưởng thức ca hò
    Huế sẽ rất thú vị.
    <h3>Huế có lễ hội gì đặc sắc?</h3>
    Tại Huế định kỳ 2 năm 1 lần vào các năm chẵn sẽ tổ chức Festival Huế, thường vào dịp cuối tháng 4. Hay đến vào dịp
    2/9 bạn sẽ được hòa mình vào lễ hội đua ghe được tổ chức bên bờ sông Hương. Nếu thích xem đấu vật bạn có thể ghé Huế
    vào mồng mười tháng giêng âm lịch hàng năm để xem lễ hội Vật Làng Sình (huyện Phú Vang).
    <h3>Khách sạn và ẩm thực địa phương</h3>
    Tại Huế có rất nhiều khách sạn để bạn lựa chọn, bạn nên tham khảo trước giá và các đánh giá của những du khách đã
    từng ở trước trên các website như Agoda hay Tripadvisor để có lựa chọn tốt nhất theo khả năng chi trả của mình. Giá
    khách sạn tại Huế tương đối mềm hơn so với Đà Nẵng hay Hội An, nên bạn đừng ngần ngại lựa chọn dòng khách sạn 3-4
    sao tại đây.

    Huế là vùng đất của ẩm thực cung đình, nên khi đến đây bạn có thể ghé vào các nhà hàng như Cung Đình để vừa thưởng
    thức các món ăn cung đình như nem công, chả phụng, cơm cung đình, súp hạt sen, tôm ngự thuyền rồng... vừa được nghe
    nhã nhạc Huế trong trang phục hoàng tộc và không gian cung đình Huế. Ngoài ra còn có những món ăn quen thuộc mà dân
    dã như cơm Hến Huế, bún bò Huế (nổi tiếng nhất ở số 13 Lý Thường Kiệt), nem lụi Huế, các loại bánh như Bánh bèo,
    bánh bột lọc, bánh khoái. Cơm chay Huế tại số 3 Lê Quý Đôn, và những bạn là tín đồ của chè thì không nên bỏ qua quán
    chè hẻm nằm sâu tít trong đường Hùng Vương với 19 loại chè cực ngon.
    <h3>Đến Huế mua gì về làm quà?</h3>
    Mè xửng, hạt sen, bưởi Thanh Trà, các loại mắm Huế (mắm cá cơm, tôm chua, mắm ruốc, mắm rò), mứt gừng Huế. Và những
    sản phẩm tô điểm thêm cho ngôi nhà của bạn như hoa giấy Thanh Tiên hay nón Bài Thơ là những đặc sản của xứ Huế mà
    bạn có thể mua về làm quà cho người thân, bạn bè.
    <h3>Những điều lưu ý</h3>
    Bạn nên hạn chế đến Huế vào mùa mưa từ tháng 9 – 12, đặc biệt tháng 10 là mùa lũ lụt. Và mùa đông ở Huế thường rất
    lạnh và buốt, có khi nhiệt độ xuống đến 90C (tháng 1 – 2). Nhớ nhé, thời tiết huế khá thất thường, ngay cả khi trời
    nắng bạn cũng có thể gặp những cơn mưa bất chợt. Bởi thế lúc nào cũng phải mang theo 1 chiếc ô.
    </pre>", "2023-12-05 19:37:43"),
    (7, "Kinh nghiệm du lịch Đà Nẵng", "Đà Nẵng là thành phố thuộc vùng duyên hải Nam Trung Bộ, thành phố vừa hiện đại, sạch đẹp
vừa yên bình này nổi tiếng với những tên gọi như thành phố đáng sống nhất Việt Nam, thành phố của những chiếc cầu hay
thành phố của những bãi biển. Với chiều dài hơn 60km, biển Đà Nẵng được tạp chí Forbes của Mỹ bình chọn là 1 trong 6 bãi
biển quyến rũ nhất hành tinh, đến đây du khách còn được tham quan những thắng cảnh ấn tượng như bán đảo Sơn Trà, khu du
lịch Bà Nà Hills, danh thắng Ngũ Hành Sơn… Ngoài ra", "
<pre>
    <h1>Kinh nghiệm du lịch Đà Nẵng</h1>
    Đà Nẵng là thành phố thuộc vùng duyên hải Nam Trung Bộ, thành phố vừa hiện đại, sạch đẹp vừa yên bình này nổi tiếng
    với những tên gọi như thành phố đáng sống nhất Việt Nam, thành phố của những chiếc cầu hay thành phố của những bãi
    biển. Với chiều dài hơn 60km, biển Đà Nẵng được tạp chí Forbes của Mỹ bình chọn là 1 trong 6 bãi biển quyến rũ nhất
    hành tinh, đến đây du khách còn được tham quan những thắng cảnh ấn tượng như bán đảo Sơn Trà, khu du lịch Bà Nà
    Hills, danh thắng Ngũ Hành Sơn… Ngoài ra

    <h3>Phương tiện đi lại</h3>
    Hiện nay có rất nhiều phương tiện đến Đà Nẵng cho bạn lựa chọn là máy bay, tàu hỏa hay xe khách. Tuy nhiên mình
    khuyên bạn nếu sắp xếp được thời gian và lên lịch cho kỳ nghỉ rồi thì nên đặt vé máy bay sẽ thuận tiện hơn, cách
    hãng hàng không VietJetAir, Jetstar hay Vietnam Airlines thường xuyên có chương trình khuyến mãi với giá cả rất hấp
    dẫn từ 3 đầu Tp.HCM, Hà Nội và Cần Thơ. Từ sân bay Đà Nẵng về thành phố tầm 6km nên bạn đi xe taxi sẽ rất thuận
    tiện.

    Ngoài ra, nếu không đặt được vé máy bay bạn có thể đi tàu hỏa với giá cả cũng rất hợp lý tùy theo bạn lựa chọn ghế
    ngồi hay giường nằm, đặc biệt ga Đà Nẵng nằm ngay trung tâm nên bạn thuận tiện đi lại. Còn nếu chọn xe khách thì bạn
    dễ dàng mua vé từ bến xe tại TP.HCM hay Hà Nội. Tại thành phố Đà Nẵng bạn nên thuê xe máy đi tham quan vì khoảng
    cách các điểm không quá xa nên bạn thuận tiện tham quan trong thời gian ở lại đây.
    <h3>Nên đi Đà Nẵng mùa nào?</h3>
    Nếu muốn có cảm giác se lạnh thì đến Đà Nẵng từ tháng 1-3, tuy nhiên cũng không phải quá lạnh mà nhiệt độ chỉ ở
    ngưỡng vừa phải. Còn đến vào tháng 4-5 thì tuy đã chuyển sang hè nhưng đôi khi vẫn còn sương mù. Thời điểm đẹp nhất
    để đến Đà Nẵng sẽ là tháng 6-9 bởi bước vào mùa hè của miền Trung, trời nắng ráo và biển trong xanh, thích hợp cho
    chuyến vui chơi dạo biển của bạn.
    <h3>Những điểm nào nên tham quan khi đến Đà Nẵng</h3>
    Thành phố Đà Nẵng nổi tiếng với những bãi biển đẹp nên đến đây bạn không nên bỏ qua việc ngâm mình trong các bãi
    biển như biển Mỹ Khê, bãi tắm Xuân Thiều, bãi tắm ở Bán Đảo Sơn Trà hoặc bãi tắm Non Nước. Ngay khu vực trung tâm Đà
    Nẵng bạn nên ghé tham quan bảo tàng Đà Nẵng trưng bày những cổ vật của Chămpa hay tham quan công viên Châu Á với
    những trò chơi hấp dẫn cùng vòng quay mặt trời Sun Wheel hiện là 1 trong 10 vòng quay lớn nhất thế giới. Đi xa chừng
    16km bạn sẽ đến với Bán đảo Sơn Trà, viếng Chùa Linh Ứng, tham quan đỉnh Bàn Cờ, Bãi Bụt, Bãi Bắc, khu du lịch Bãi
    Cát Vàng và sân bay trực thăng Sơn Trà.

    Ngày hôm sau tại Đà Nẵng bạn tiếp tục tham quan danh thắng Ngũ Hành Sơn cách trung tâm thành phố Đà Nẵng khoảng 12km
    hướng về Hội An, sau đó về lại thành phố Đà Nẵng và tiếp tục hành trình khám phá Bà Nà Hills, cách Đà Nẵng 30km. Đến
    Bà Nà bạn không quên trải nghiệm dịch vụ đi tàu lửa, tham quan vườn hoa Le Jardin D'Amour và khu Làng Pháp xinh đẹp.
    Buổi tối tại Đà Nẵng thì đừng quên trải nghiệm dịch vụ di thuyền trên sông Hàn về đêm và chiêm ngưỡng những cây cầu
    làm nên tên tuổi của thành phố Đà Nẵng đó là cầu sông Hàn, cầu Rồng, cầu Trần Thị Lý, cầu Thuận Phước.
    <h3>Đà Nẵng có lễ hội gì đặc sắc?</h3>
    Đà Nẵng nổi tiếng với Lễ hội pháo hoa Đà Nẵng được tổ chức 2 năm một lần, thường được tổ chức vào năm lẻ, hoạt động
    diễn ra vào cuối tháng 4. Ngoài ra, Đà Nẵng còn có Lễ hội đua thuyền diễn ra vào tháng Giêng âm lịch hàng năm, lễ
    hội Cầu Ngư tổ chức sau khi ăn Tết và lễ hội Quan Thế Âm vào ngày 19.2 Âm lịch hàng năm.
    <h3>Khách sạn và ẩm thực địa phương</h3>
    Là một thành phố du lịch nổi tiếng nên Đà Nẵng được đầu tư rất nhiều về hệ thống giao thông, dịch vụ du lịch như
    khách sạn, nhà hàng. Vì vậy bạn dễ dàng tìm thấy những khách sạn với mức giá phải chăng đến những khách sạn cao cấp,
    resort 4-5 sao dọc bãi biển. Để có những lựa chọn tối ưu bạn nên tham khảo thông tin đánh giá trên Agoda hay
    Tripadvisor. Ngoài ra, nếu muốn thức dậy trong khi khí se lạnh và trải nghiệm cảm giác thiên nhiên thì bạn nên đặt 1
    đêm phòng trên Bà Nà Hilss tại khách sạn Lệ Nim hay khu Làng Pháp, mình tin cảm giác sẽ rất khác bởi không gian ở
    đây rất lãng mạng và nên thơ.

    Đà Nẵng có thể được xem là thiên đường của ẩm thực, bởi đến đây bạn không chỉ thưởng thức hải sản tươi sống mà còn
    ăn được những món ăn độc đáo của miền Trung như Mỳ Quảng, bánh tráng cuốn thịt heo, bún mắm, bê thui Cầu Mống, bún
    chả cá, gỏi cá Nam Ô, nem lụi, bánh xèo, bánh bèo – nậm lọc, bún bò.... Ngoài ra, nếu muốn ngắm phong cảnh về đêm
    của Đà Nẵng thì bạn nên đến Sky Bar cao nhất Việt Nam tại tầng 36 của khách sạn Novotel Đà Nẵng, giá cả cũng rất
    phải chăng với nhiều loại thức uống được phục vụ.
    <h3>Đến Đà Nẵng mua gì về làm quà?</h3>
    Bạn có thể mua các loại hải sản tươi sống hoặc khô như mực, tôm, cá khô tẩm tại chợ Cồn hay chợ Hàn…Các loại bánh
    tré Bà Đệ, rong biển Mỹ Khê, nước nắm Nam Ông…là những món quà đặc sản du khách thường mua về làm quà khi tới Đà
    Nẵng.
    <h3>Những điều lưu ý</h3>
    Tháng 10-12 Đà Nẵng (và miền Trung) bắt đầu vào mùa mưa, bão nên không thuận lợi cho các bạn di chuyển, nếu đến Đà
    Nẵng lúc này gần như chỉ có thể trải nghiệm cảm giác mưa bão miền Trung kết hợp với tour khám phá ẩm thực Đà Nẵng mà
    thôi. Nhớ là mưa miền Trung khá dai bạn nhé có thể kéo dài từ sáng đến chiều và từ tháng này qua tháng nọ. Và bạn
    nên nhớ là người dân Đà Nẵng rất nhiệt tình và hiếu khách nên muốn hỏi đường đi thì bạn đừng ngần ngại nhé, họ rất
    sẵn lòng và chỉ dẫn tận tình.
    </pre>", "2023-12-20 07:45:32");

-- Example data for comment
INSERT INTO comment(user_id, post_id, content, reply_date)
VALUES (4, 3, 'Mình cùng nhóm bạn đang định đi Cô Tô nhưng không biết lên lịch trình như nào thì đọc được bài viết của bạn. Cảm ơn vì sự chia sẻ của bạn.', '2023-12-14 18:25:45'),
	(8, 1, 'Đọc bài viết của bạn xong làm mình háo hức muốn đi Đà Lạt quá!!!', '2023-12-14 20:38:21'),
    (2, 2, 'Mai mình sẽ đi săn hoa mai anh đào Đà Lạt thử theo bài viết của bạn xem sao.', '2023-12-16 08:12:32');

SELECT * FROM available_tour;
SELECT * FROM account;
SELECT * FROM post;
SELECT * FROM comment;

-- Update image to available_tour
UPDATE `tourweb`.`available_tour` SET `image` = 'images/tour/1.jpg' WHERE (`id` = '1');
UPDATE `tourweb`.`available_tour` SET `image` = 'images/tour/2.jpg' WHERE (`id` = '2');
UPDATE `tourweb`.`available_tour` SET `image` = 'images/tour/3.jpg' WHERE (`id` = '3');
UPDATE `tourweb`.`available_tour` SET `image` = 'images/tour/4.jpg' WHERE (`id` = '4');
UPDATE `tourweb`.`available_tour` SET `image` = 'images/tour/Ninh-Binh.jpg' WHERE (`id` = '5');
UPDATE `tourweb`.`available_tour` SET `image` = 'images/tour/6.jpg' WHERE (`id` = '6');
UPDATE `tourweb`.`available_tour` SET `image` = 'images/tour/7.jpg' WHERE (`id` = '7');
UPDATE `tourweb`.`available_tour` SET `image` = 'images/tour/8.jpg' WHERE (`id` = '8');
UPDATE `tourweb`.`available_tour` SET `image` = 'images/tour/9.jpg' WHERE (`id` = '9');
UPDATE `tourweb`.`available_tour` SET `image` = 'images/tour/10.jpg' WHERE (`id` = '10');
UPDATE `tourweb`.`available_tour` SET `image` = 'images/tour/11.jpg' WHERE (`id` = '11');
UPDATE `tourweb`.`available_tour` SET `image` = 'images/tour/12.jpg' WHERE (`id` = '12');
UPDATE `tourweb`.`available_tour` SET `image` = 'images/tour/13.jpg' WHERE (`id` = '13');
UPDATE `tourweb`.`available_tour` SET `image` = 'images/tour/14.jpg' WHERE (`id` = '14');
UPDATE `tourweb`.`available_tour` SET `image` = 'images/tour/15.jpg' WHERE (`id` = '15');
UPDATE `tourweb`.`available_tour` SET `image` = 'images/tour/16.jpg' WHERE (`id` = '16');
UPDATE `tourweb`.`available_tour` SET `image` = 'images/tour/17.jpg' WHERE (`id` = '17');
UPDATE `tourweb`.`available_tour` SET `image` = 'images/tour/18.jpg' WHERE (`id` = '18');
UPDATE `tourweb`.`available_tour` SET `image` = 'images/tour/19.jpg' WHERE (`id` = '19');
UPDATE `tourweb`.`available_tour` SET `image` = 'images/tour/20.jpg' WHERE (`id` = '20');

-- Update image to post
UPDATE `post` SET `image` = 'images/post/1.jpg' WHERE (`id` = '11');
UPDATE `post` SET `image` = 'images/post/2.jpg' WHERE (`id` = '12');
UPDATE `post` SET `image` = 'images/post/3.jpg' WHERE (`id` = '13');
UPDATE `post` SET `image` = 'images/post/4.jpg' WHERE (`id` = '14');
UPDATE `post` SET `image` = 'images/post/5.jpg' WHERE (`id` = '15');

-- Update availabler_tour to have default value for max_number_of_tourist
ALTER TABLE available_tour
ALTER COLUMN max_number_tourist SET DEFAULT 30;


-- Format again content of post
UPDATE `tourweb`.`post` SET `content` = '<pre> 
<h3>Phương tiện đi lại</h3> 
Từ TP.HCM, Đà Nẵng hay Cần Thơ thì phương tiện thuận tiện và tiết kiệm thời gian nhất bạn nên chọn là máy bay, bởi hiện nay các hãng hàng không Vietjet, Jestar hay Vietnam Airlines luôn có nhiều chương trình khuyến mãi hấp dẫn, bạn nên đăng ký địa chỉ mail để các hãng hàng không gởi thông tin khuyến mãi nhé. Ngoài ra, bạn có thể chọn xe lửa tàu Thống Nhất Bắc Nam tuy nhiên lưu ý bạn chỉ nên chọn khi có nhiều thời gian tham quan. 
Từ sân bay Nội Bài về trung tâm khoảng 30km, bạn có thể đi taxi nếu đi đông hay chọn xe bus trung chuyển của hai hãng hàng không nội địa là Jetstar và VietJet Air với giá mềm hơn. Trong trung tâm Hà Nội để tham quan bạn nên thuê xe máy để di chuyển, ngoài ra còn 2 phương tiện cũng khá độc đáo để thăm thủ đô là xích lô và xe điện. 
<h3>Nên đi Hà Nội mùa nào?</h3> 
Thời gian thích hợp nhất để du lịch Hà Nội là vào tháng 9 đến tháng 11 hoặc từ tháng 3 đến tháng 4, đó là lúc chuyển mùa thời tiết ấm áp và dễ chịu, không quá nắng gắt hay hanh khô. Tuyệt vời nhất là vào mùa thu, Hà Nội như khoác một chiếc áo mới, dịu dàng và lãng mạng nhất trong năm. 
<h3>Những điểm nào nên tham quan khi đến Hà Nội</h3>
Hà Nội có rất nhiều điểm tham quan di tích lịch sử - văn hóa để bạn tham quan tìm hiểu, ngay khu vực trung tâm thủ đô bạn hãy ghé tham quan Hồ Hoàn Kiếm, ngắm tháp Rùa, đền Ngọc Sơn, cầu Thê Húc. Chiêm ngưỡng và chụp hình tại Nhà thờ lớn Hà Nội, Nhà hát lớn Hà Nội, khu phố Cổ. Xa hơn một chút tầm 3km bạn hãy viếng Lăng Bác (lưu ý Lăng không mở thứ 2, 6 hàng tuần) thăm quan Bảo tàng Hồ Chí Minh, nhà sàn Bác Hồ, chùa Một Cột, quảng trường Ba Đình; tiếp tục tham quan Văn Miếu - Quốc Tử Giám - nơi thờ Khổng Tử và các bậc hiền triết của Nho Giáo, Hoàng Thành Thăng Long. 
Ngày hôm sau tại Hà Nội bạn hãy ghé khu vực Hồ Tây, tham quan Đền Quán Thánh, chùa Trấn Quốc. Thích tìm hiểu về văn hóa các dân tộc thì bạn ghé tham quan Bảo tàng dân tộc học Việt Nam, nếu còn thời gian tại Hà Nội bạn hãy ghé các khu vực lân cận như làng gốm Bát Tràng (cách trung tâm 20km), làng cổ Đường Lâm (cách trung tâm 45km) nơi còn lưu giữ những nét cổ xưa của một làng quê miền Bắc. 
<h3>Hà Nội có lễ hội gì đặc sắc?</h3> 
Lễ hội Chùa Hương là lễ hội đặc sắc nhất ở Hà Nội, được diễn ra từ mùng 6 tháng Giêng đến hết tháng 3 âm lịch, tuy nhiên trong giai đoạn lễ hội thường rất đông nên bạn có thể đi dịp trước tết dương lịch và nguyên đán. Ngoài ra, Hà Nội còn có các lễ hội như Hội gò Đống Đa mùng 5 Tết tại gò Đống Đa, lễ hội đền Gióng Sóc Sơn ngày 6/1 âm lịch, lễ hội Cổ Loa diễn ra từ ngày 6 đến 16 tháng giêng âm lịch (chính hội ngày 6). 
<h3>Khách sạn và ẩm thực địa phương</h3>
Hà nội có rất nhiều khách sạn để bạn lựa chọn, để tham khảo các khách sạn hợp với túi tiền và vị trí gần trung tâm phố cổ bạn nên tham khảo trước trên các web tư vấn khách sạn như Agoda hay Tripadvisor rất hữu ích. Ngoài ra, mình tư vấn cho bạn một số khách sạn như Asian Star, Chaerry 2, Crysral 2 sao hay khách sạn 3 sao như Boss, ATS, Church Boutique. 
Ẩm thực Hà Nội luôn hấp dẫn với những món ăn đậm chất riêng. Một số món ăn không thể bỏ qua khi du lịch Hà Nội: phở gánh Hàng Trống, chả cá Lã Vọng, bún chả, bún thang, bánh cốm, bánh cuốn, bún đậu mắm tôm. 
<h3>Đến Hà Nội mua gì về làm quà?</h3> 
Hà Nội có khá nhiều sản phẩm để bạn mua về làm quà cho người thân như các sản phẩm sơn mài, thủ công, đồ lưu niệm như đồ trang trí bằng bạc, gốm sứ và đồ trang sức dọc phố Hàng Khay, Tràng Tiền; sản phẩm lụa cũng khá đẹp bạn có thể mua tại phố Hàng Gai, phố Nha Thờ. Ngoài ra, các đặc sản mua về ăn như Ô Mai (hàng Đường), bánh cốm (Hàng Than) hay bánh đậu xanh (hàng Điếu) rất được du khách ưu chuộng khi mua về. 
<h3>Những điều lưu ý</h3>
Miền Bắc có bốn mùa rõ rệt trong năm, chính vì vậy thời tiết là điều bạn cần quan tâm khi đi du lịch Hà Nội. Mùa hè trời thường rất nắng nóng, mùa đông thì rất lạnh, mùa xuân thì hay mưa phùn, ẩm ướt. Hãy có một tấm bản đồ để xác định quãng đường đi, tránh việc bị người khác (xe ôm, taxi) đưa đi lòng vòng rồi tính tiền. Hãy hỏi về giá cả trước khi sử dụng bất cứ dịch vụ nào. Cách tốt nhất là bạn nên nhờ lễ tân tại khách sạn mình ở tư vấn, giúp đỡ khi cần thông tin. Để thưởng thức hết vẻ đẹp thiên nhiên, kiến trúc kỳ vĩ ở các chùa lớn thì không nên đi các chùa vào mùa lễ hội. 
</pre>' WHERE (`id` = '1');
UPDATE `tourweb`.`post` SET `content` = '<pre> 
<h3>Phương tiện đi lại</h3> 
Hạ Long cách Hà Nội khoảng 150km, bạn có thể ra bến xe Lương Yên, Mỹ Đình để bắt xe đi Hạ Long, có nhiều nhà xe và chạy liên tục trong ngày, xe chạy khoảng 4 tiếng. Với những chuyến đi 2 ngày 1 đêm với dịch vụ ngủ đêm trên du thuyền thì bạn an tâm là du thuyền đón bạn tại khách sạn nên sẽ không lo vận chuyển xuống Hạ Long. Từ miền Trung hay miền Nam đến Hạ Long thì bạn có thể lựa chọn bay trực tiếp đến Hà Nội hoặc Hải Phòng sau đó bắt xe đi Hạ Long, riêng miền Tây thì chỉ có bay trực tiếp đến Hà Nội thôi nhé. 
<h3>Nên đi Hạ Long mùa nào?</h3> 
Thời điểm tốt nhất để tham quan Hạ Long là vào mùa hè (tháng 4 – 10), lưu ý tháng 6 – 7 thường có mưa bão nên hạn chế thời gian này. Mùa đông ở Hạ Long rất lạnh (tháng 11 – 3 năm sau), nên bạn lưu ý mang theo áo ấm nhé. 
<h3>Những điểm nào nên tham quan khi đến Hạ Long</h3> 
Trên đường ra Hạ Long nếu đi bằng xe máy bạn có thể ghé tham quan núi Yên Tử, cách thành phố Hạ Long 73km, núi Yên Tử khá rộng và phải di chuyển bằng cáp treo 2 lượt nên nếu tham quan cả Chùa Đồng bạn sẽ mất một ngày. Chiều trên đường về Hạ Long bạn tiếp tục ghé tham quan Chùa Ba Vàng, cách Yên Tử 35km và cách Hạ Long 40km. Ngày hôm sau bắt đầu chuyến hành trình khám phá Vịnh bạn có thể lựa chọn tuyến tham quan Động Thiên Cung và Hang Dấu Gỗ (4 tiếng) hoặc Hang Sửng Sốt và Đảo Ti Tốp (6 tiếng), trên đường đi bạn sẽ được nhìn thấy Hòn Đỉnh Hương, Hòn Gà Chọi… 
Nếu còn thời gian tại Hạ Long bạn có thể ghé tham quan Làng chải Cửa Vạn để tìm hiểu cuộc sống của ngư dân miền biển và tham gia vào những cuộc đánh bắt cá, câu cá, mực, chèo thuyền với ngư dân. Muốn tắm biển thì ghé đảo Ti Tốp, biển Tuần Châu hay Bãi Cháy. Hay tìm hiểu về di tích lịch sử Hạ Long thì bạn nên ghé núi Bài Thơ, đền thờ Trần Quốc Nghiễm, chùa Cửa Ông, bảo tàng Quảng Ninh. Ngoài ra, Đảo Cô Tô cũng là một điểm đến thú vị mà du khách Hà Nội thường lựa chọn vào dịp hè (cách Hạ Long 60km), đảo hiện tại vẫn còn giữ nét hoang sơ nên biển rất xanh và êm ả.
<h3>Hạ Long có lễ hội gì đặc sắc?</h3> 
Lễ Hội đặc sắc nhất tại Hạ Long mà du khách hay quan tâm là Carnaval Hạ Long thường tổ chức định kỳ tháng 4 hàng năm tại Quảng Trường thành phố Hạ Long. Trong tháng 4 còn có lễ hội Hoa Anh Đào Hạ Long với hàng trăm cành đào đến từ Nhật Bản. Ngoài ra, tại Hạ Long còn có lễ hội Yên Tử được tổ chức thường niên, bắt đầu từ ngày 10 tháng giêng và kéo dài hết tháng 3 (âm lịch), lễ hội Đền Cửa Ông diễn ra từ 2/1 – 30/3 âm lịch, lễ hội Bạch Đằng được tổ chức vào ngày mùng 8 tháng 3 (âm lịch) hàng năm. 
<h3>Khách sạn và ẩm thực tại địa phương</h3> 
Hạ Long được phân ra làm 2 khu: Hòn Gai và Bãi Cháy, được nối với nhau bởi cây cầu Bãi Cháy. Khu du lịch chính là Bãi Cháy, với bờ biển chạy dài và các cảng du lịch. Khu Hòn Gai là khu trung tâm hành chính. Bạn nên ở khu Bãi Cháy cho thuận tiện đi lại và ăn uống. Tại Bãi Cháy có rất nhiều khách sạn để bạn lựa chọn, trước khi quyết định đặt khách sạn nào bạn nên tham khảo đánh giá của các khách ở trước trên web Agoda hay Tripadviser để có thêm thông tin tham khảo. Một vài khách sạn gợi ý cho bạn các khách sạn 3 sao như Blue Sky, BMC Thăng Long, Golden Lotus, City Bay Palace. Ngoài ra, bạn nên trải nghiệm một đêm trên du thuyền Hạ Long sẽ rất thú vị, các du thuyền mình hay ngủ đêm như Bài Thơ, Pelican, Halong Emotion. 
Hạ Long là thiên đường của hải sản nên đến đây bạn không nên bỏ qua món chả Mực, hàu nướng, Sam xào chua ngọt, Sá Sùng, bún tôm, bún xào Ngán, tu hài Vân Đồn. Ngoài ra các món nem chua và canh hà Quảng Yên Cà Sáy (vịt lai nga) cũng rất hấp dẫn. 
<h3>Đến Hạ Long mua gì về làm quà?</h3> 
Hạ Long có khá nhiều mặt hàng để bạn mua về làm quà cho người thân như đồ hải sản gồm mực khô, sá sùng khô, chả mực được bán nhiều tại các chợ Cái Dăm, chợ Hạ Long 1, Hạ Long 2. Đồ lưu niệm được chế tác từ vỏ sinh vật biển, than đá, gỗ, khảm trai, ngọc trai, các sản phẩm này bạn có thể mua tại cửa hàng lưu niệm Hòn Gai hoặc chợ đêm Hạ Long. Ngoài ra, còn có rượu Ngán Hạ long, nem chua Quảng Yên, Cà sáy (vịt lai ngan) bạn có thể mua về để cả gia đình cùng thưởng thức. 
<h3>Những điều lưu ý</h3> 
Mua hàng tại Hạ Long thì bạn lưu ý dò hỏi giá ở nhiều cửa hàng để so sánh trước khi quyết định mua vì đa số các cửa hàng đều nói thách. Khi ngủ đêm trên du thuyền lưu ý giữ gìn vệ sinh cảnh quan môi trường biển. Nếu đi đảo Cô Tô bạn nên tránh lúc thời tiết gió bão vì tàu thuyền sẽ không được phép chạy nếu sóng quá lớn. 
</pre>' WHERE (`id` = '2');
UPDATE `tourweb`.`post` SET `content` = '<pre> 
<h3>Phương tiện đi lại</h3> 
Cách Hà Nội chỉ 100km nên bạn có thể tham quan Ninh Bình bằng xe máy hoặc xe khách, nhưng mình khuyên bạn nên đi xe khách vì thuận tiện và sức khỏe. Các bến xe khách đi Ninh Bình đó là Giáp Bát và Mỹ Đình, hàng ngày đều có các chuyến xe khách Bắc Nam chạy liên tục. Nếu đi Open Bus bạn có thể đi của hãng The Sinh Tourist hoặc Hưng Thành. Vì các điểm tham quan ở Ninh Bình cách xa nhau nên đến Ninh Bình bạn nên thuê xe máy để thuận tiện di chuyển. Các bạn từ TP.HCM, miền Tây hay miền Trung thì nên đặt vé máy bay giá rẻ để đến Hà Nội trước, sau đó kết hợp tham quan Ninh Bình. 
<h3>Nên đi Ninh Bình mùa nào?</h3> 
Nếu muốn đi viếng chùa Bái Đính thì nên đến vào những ngày đầu năm (từ mùng 6 đến tháng 3 âm lịch), còn đam mê chụp ảnh mùa vàng Tam Cốc thì bạn nên đến vào tháng 5 – 6. Những điểm nào nên tham quan khi đến Ninh Bình Để tham quan hết các điểm đặc sắc tại Ninh Bình bạn mất 2 – 3 ngày. Ngày đầu tiên đến Ninh Bình bạn hãy ghé thăm Chùa Bái Đính và Khu du lịch Tràng An – di sản thiên nhiên và địa chất thế giới, Tràng An khá rộng nên mất khoảng 3 tiếng ngồi thuyền, các hang động tại Tràng An khá dài và rộng hang Hang Cả, Hang Hai, Hang Ba. 
Ngày thứ 2 tại Ninh Bình bạn hãy ghé thăm nhà thờ Phát Diệm cách trung tâm Ninh Bình 30km, trưa về ghé tham quan Cố Đô Hoa Lư – đền thờ vua Đinh, vua Lê. Ngoài ra nếu còn thời gian tại Ninh Bình bạn hãy ghé tham quan Tam Cốc, hệ thống hang động ít và ngắn hơn Tràng An nhưng tuyệt đẹp vào mùa lúa (tháng 5 – 6), chùa Bích Động (cùng hướng Tam Cốc). Khu bảo tồn thiên nhiên Vân Long - khu bảo tồn thiên nhiên ngập nước lớn nhất đồng bằng Bắc Bộ, tại đây còn có suối nước nóng Kênh Gà, động Vân Trình, Kẽm Trống và nhiều núi hang đẹp khác. Ngoài ra còn có động Thiên Hà và Vườn Quốc Gia Cúc Phương cho những yêu thiên nhiên và khám phá. 
<h3>Ninh Bình có lễ hội gì đặc sắc</h3> 
Nếu đến vào dịp đầu năm bạn sẽ tham quan Lễ hội chùa Bái Đính là một lễ hội xuân được tổ chức hàng năm, diễn ra từ ngày mùng 6 Tết đến hết tháng 3 âm lịch. Ngoài ra trong tháng 3 (mồng 10 tháng 3 âm lịch) còn có lễ hội Hoa Lư, tương truyền là ngày vua Đinh lên ngôi hoàng đế, nhân dân Trường Yên lại mở hội tưởng nhớ Đinh Tiên Hoàng. 
<h3>Khách sạn và ẩm thực địa phương</h3> 
Trước khi quyết định đặt phòng bạn hãy tham khảo thêm các đánh giá của những người từng ở trước trên các trang web như Agoda hay Tripadvisor để lựa chọn khách sạn mình thích và hợp túi tiền. Một số khách sạn gợi ý mình đánh giá tốt như Tuấn Ngọc 1 sao, Canh Dieu Moutain, Ngọc Anh & Kinh Đô 2 sao, còn 3 sao thì có Bái Đính và khách sạn Queen. 
Nhắc đến Ninh Bình là nhắc đến dê núi, vì vậy bạn không quên thưởng thức món dê núi (được chế biến gần 20 món) ăn kèm cơm cháy, ngoài ra còn có những món đặc sắc như gỏi cá nhệch Kim Sơn, ốc núi, nem Yên Mạc, canh chua cá rô, miến lươn chắc chắc sẽ làm bạn hài lòng. 
<h3>Đến Ninh Bình mua gì về làm quà?</h3> 
Gợi ý một số sản vật Ninh Bình bạn có thể mua về là quà cho người thân là rượu cần Nho Quan, hàng mỹ nghệ từ cói Ninh Bình (như thảm, khay, túi xách, cốc, mũ) và món ăn đặc sản cơm cháy chà bông. 
<h3>Những điều lưu ý</h3> 
Mùa mưa ở Ninh Bình từ tháng 5 – tháng 9 nên bạn nhớ mang theo dù khi đi du lịch, còn mùa đông (tháng 12 – tháng 1) thì nên mang theo áo ấm vì mua đông miền Bắc khá lạnh và buốt. 
</pre>' WHERE (`id` = '3');
UPDATE `tourweb`.`post` SET `content` = '<pre> 
<h3>Phương tiện đi lại</h3> 
Để đến Huế bạn có thể lựa chọn nhiều phương tiện như xa khách, tàu hỏa, máy bay. Nhưng tốt nhất mình khuyên bạn nên chọn máy bay để tiết kiếm thời gian nếu di chuyển từ TP.HCM và Hà Nội, và vì các hãng hàng không của Việt Nam (Vietjet, Jestar, Vietnam Airlines) thường có nhiều chương trình khuyến mãi, bạn lưu ý đăng ký mail để có thông tin khuyến mãi của hàng không. Còn từ Cần Thơ bạn nên bay trực tiếp đến Đà Nẵng, sau đó kết hợp chuyến hành trình tham quan Huế, chỉ cách 100km. 
Tại thành phố Huế thì bạn nên lựa chọn phượng tiện phổ biến là thuê xe máy dể dạo quanh phố phường, bạn có thể dễ dàng thuê tại các khách sạn mình ở. Ngoài ra, bạn có thể thuê xích lô tham quan cố đô và trong khu Đại Nội Huế cũng rất thú vị. 
<h3>Nên đi Huế mùa nào?</h3> 
Bạn nên đến Huế vào mùa khô từ tháng 3 – tháng 8, có khi nhiệt độ lên tới 35-400C tuy nhiên đây là mùa khô ráo nên bạn có thể tham quan và khám phá trọn vẹn cố đô Huế. Ngoài ra, để hiểu về bản sắc văn hóa Huế bạn nên đến vào dịp Festival Huế (được tổ chức 2 năm 1 lần vào các năm chẵn vào cuối dịp tháng 4. 
<h3>Những điểm nào nên tham quan khi đến Huế</h3>
Ngày đầu đến Huế bạn nên ghé tham quan Hoàng Cung Huế, cách trung tâm tầm 6km, điểm tham quan này khá rộng nên mất gần 1 buổi, tại đây có lễ đổi gác từ 9h00 – 9h30 hàng ngày nên bạn chú ý xem để biết hoạt động đổi gác ngày xưa dưới thời vua chúa như thế nào nhé. Nếu còn thời gian buổi sáng bạn có thể ghé tham quan Chùa Thiên Mụ, cách Hoàng Cung Huế 6km. Buổi chiều thì bạn nên tham quan lăng của các vua Triều Nguyễn như Minh Mạng, Tự Đức, Khải Định, Gia Long, Thiệu Trị, Đồng Khánh trong phạm vị bán kính tầm 7 – 12km. 
Nếu còn thời gian ở lại Huế bạn có thể đi thuyền trên sông Hương tham quan ghé Điện Hòn Chén, làng hoa giấy Thanh Tiên. Tắm biển Thuận An cách trung tâm Huế 18km, ghé Phá Tam Giang ngắm hoàng hôn hay thư giãn tại Suối khoáng nóng Thanh Tân (cách Huế 31km). Buổi tối ở Huế bạn hãy đi thuyền trên sông Hương, thả đèn hoa đăng và thưởng thức ca hò Huế sẽ rất thú vị. 
<h3>Huế có lễ hội gì đặc sắc?</h3> 
Tại Huế định kỳ 2 năm 1 lần vào các năm chẵn sẽ tổ chức Festival Huế, thường vào dịp cuối tháng 4. Hay đến vào dịp 2/9 bạn sẽ được hòa mình vào lễ hội đua ghe được tổ chức bên bờ sông Hương. Nếu thích xem đấu vật bạn có thể ghé Huế vào mồng mười tháng giêng âm lịch hàng năm để xem lễ hội Vật Làng Sình (huyện Phú Vang). 
<h3>Khách sạn và ẩm thực địa phương</h3> 
Tại Huế có rất nhiều khách sạn để bạn lựa chọn, bạn nên tham khảo trước giá và các đánh giá của những du khách đã từng ở trước trên các website như Agoda hay Tripadvisor để có lựa chọn tốt nhất theo khả năng chi trả của mình. Giá khách sạn tại Huế tương đối mềm hơn so với Đà Nẵng hay Hội An, nên bạn đừng ngần ngại lựa chọn dòng khách sạn 3-4 sao tại đây. 
Huế là vùng đất của ẩm thực cung đình, nên khi đến đây bạn có thể ghé vào các nhà hàng như Cung Đình để vừa thưởng thức các món ăn cung đình như nem công, chả phụng, cơm cung đình, súp hạt sen, tôm ngự thuyền rồng... vừa được nghe nhã nhạc Huế trong trang phục hoàng tộc và không gian cung đình Huế. Ngoài ra còn có những món ăn quen thuộc mà dân dã như cơm Hến Huế, bún bò Huế (nổi tiếng nhất ở số 13 Lý Thường Kiệt), nem lụi Huế, các loại bánh như Bánh bèo, bánh bột lọc, bánh khoái. Cơm chay Huế tại số 3 Lê Quý Đôn, và những bạn là tín đồ của chè thì không nên bỏ qua quán chè hẻm nằm sâu tít trong đường Hùng Vương với 19 loại chè cực ngon. 
<h3>Đến Huế mua gì về làm quà?</h3> 
Mè xửng, hạt sen, bưởi Thanh Trà, các loại mắm Huế (mắm cá cơm, tôm chua, mắm ruốc, mắm rò), mứt gừng Huế. Và những sản phẩm tô điểm thêm cho ngôi nhà của bạn như hoa giấy Thanh Tiên hay nón Bài Thơ là những đặc sản của xứ Huế mà bạn có thể mua về làm quà cho người thân, bạn bè. 
<h3>Những điều lưu ý</h3> 
Bạn nên hạn chế đến Huế vào mùa mưa từ tháng 9 – 12, đặc biệt tháng 10 là mùa lũ lụt. Và mùa đông ở Huế thường rất lạnh và buốt, có khi nhiệt độ xuống đến 90C (tháng 1 – 2). Nhớ nhé, thời tiết huế khá thất thường, ngay cả khi trời nắng bạn cũng có thể gặp những cơn mưa bất chợt. Bởi thế lúc nào cũng phải mang theo 1 chiếc ô. 
</pre>' WHERE (`id` = '4');
UPDATE `tourweb`.`post` SET `content` = '<pre> 
<h3>Phương tiện đi lại</h3> 
Hiện nay có rất nhiều phương tiện đến Đà Nẵng cho bạn lựa chọn là máy bay, tàu hỏa hay xe khách. Tuy nhiên mình khuyên bạn nếu sắp xếp được thời gian và lên lịch cho kỳ nghỉ rồi thì nên đặt vé máy bay sẽ thuận tiện hơn, cách hãng hàng không VietJetAir, Jetstar hay Vietnam Airlines thường xuyên có chương trình khuyến mãi với giá cả rất hấp dẫn từ 3 đầu Tp.HCM, Hà Nội và Cần Thơ. Từ sân bay Đà Nẵng về thành phố tầm 6km nên bạn đi xe taxi sẽ rất thuận tiện. 
Ngoài ra, nếu không đặt được vé máy bay bạn có thể đi tàu hỏa với giá cả cũng rất hợp lý tùy theo bạn lựa chọn ghế ngồi hay giường nằm, đặc biệt ga Đà Nẵng nằm ngay trung tâm nên bạn thuận tiện đi lại. Còn nếu chọn xe khách thì bạn dễ dàng mua vé từ bến xe tại TP.HCM hay Hà Nội. Tại thành phố Đà Nẵng bạn nên thuê xe máy đi tham quan vì khoảng cách các điểm không quá xa nên bạn thuận tiện tham quan trong thời gian ở lại đây. 
<h3>Nên đi Đà Nẵng mùa nào?</h3> 
Nếu muốn có cảm giác se lạnh thì đến Đà Nẵng từ tháng 1-3, tuy nhiên cũng không phải quá lạnh mà nhiệt độ chỉ ở ngưỡng vừa phải. Còn đến vào tháng 4-5 thì tuy đã chuyển sang hè nhưng đôi khi vẫn còn sương mù. Thời điểm đẹp nhất để đến Đà Nẵng sẽ là tháng 6-9 bởi bước vào mùa hè của miền Trung, trời nắng ráo và biển trong xanh, thích hợp cho chuyến vui chơi dạo biển của bạn. 
<h3> Những điểm nào nên tham quan khi đến Đà Nẵng</h3> 
Thành phố Đà Nẵng nổi tiếng với những bãi biển đẹp nên đến đây bạn không nên bỏ qua việc ngâm mình trong các bãi biển như biển Mỹ Khê, bãi tắm Xuân Thiều, bãi tắm ở Bán Đảo Sơn Trà hoặc bãi tắm Non Nước. Ngay khu vực trung tâm Đà Nẵng bạn nên ghé tham quan bảo tàng Đà Nẵng trưng bày những cổ vật của Chămpa hay tham quan công viên Châu Á với những trò chơi hấp dẫn cùng vòng quay mặt trời Sun Wheel hiện là 1 trong 10 vòng quay lớn nhất thế giới. Đi xa chừng 16km bạn sẽ đến với Bán đảo Sơn Trà, viếng Chùa Linh Ứng, tham quan đỉnh Bàn Cờ, Bãi Bụt, Bãi Bắc, khu du lịch Bãi Cát Vàng và sân bay trực thăng Sơn Trà. 
Ngày hôm sau tại Đà Nẵng bạn tiếp tục tham quan danh thắng Ngũ Hành Sơn cách trung tâm thành phố Đà Nẵng khoảng 12km hướng về Hội An, sau đó về lại thành phố Đà Nẵng và tiếp tục hành trình khám phá Bà Nà Hills, cách Đà Nẵng 30km. Đến Bà Nà bạn không quên trải nghiệm dịch vụ đi tàu lửa, tham quan vườn hoa Le Jardin D’Amour và khu Làng Pháp xinh đẹp. Buổi tối tại Đà Nẵng thì đừng quên trải nghiệm dịch vụ di thuyền trên sông Hàn về đêm và chiêm ngưỡng những cây cầu làm nên tên tuổi của thành phố Đà Nẵng đó là cầu sông Hàn, cầu Rồng, cầu Trần Thị Lý, cầu Thuận Phước. 
<h3>Đà Nẵng có lễ hội gì đặc sắc?</h3> 
Đà Nẵng nổi tiếng với Lễ hội pháo hoa Đà Nẵng được tổ chức 2 năm một lần, thường được tổ chức vào năm lẻ, hoạt động diễn ra vào cuối tháng 4. Ngoài ra, Đà Nẵng còn có Lễ hội đua thuyền diễn ra vào tháng Giêng âm lịch hàng năm, lễ hội Cầu Ngư tổ chức sau khi ăn Tết và lễ hội Quan Thế Âm vào ngày 19.2 Âm lịch hàng năm. 
<h3>Khách sạn và ẩm thực địa phương</h3> 
Là một thành phố du lịch nổi tiếng nên Đà Nẵng được đầu tư rất nhiều về hệ thống giao thông, dịch vụ du lịch như khách sạn, nhà hàng. Vì vậy bạn dễ dàng tìm thấy những khách sạn với mức giá phải chăng đến những khách sạn cao cấp, resort 4-5 sao dọc bãi biển. Để có những lựa chọn tối ưu bạn nên tham khảo thông tin đánh giá trên Agoda hay Tripadvisor. Ngoài ra, nếu muốn thức dậy trong khi khí se lạnh và trải nghiệm cảm giác thiên nhiên thì bạn nên đặt 1 đêm phòng trên Bà Nà Hilss tại khách sạn Lệ Nim hay khu Làng Pháp, mình tin cảm giác sẽ rất khác bởi không gian ở đây rất lãng mạng và nên thơ. 
Đà Nẵng có thể được xem là thiên đường của ẩm thực, bởi đến đây bạn không chỉ thưởng thức hải sản tươi sống mà còn ăn được những món ăn độc đáo của miền Trung như Mỳ Quảng, bánh tráng cuốn thịt heo, bún mắm, bê thui Cầu Mống, bún chả cá, gỏi cá Nam Ô, nem lụi, bánh xèo, bánh bèo – nậm lọc, bún bò.... Ngoài ra, nếu muốn ngắm phong cảnh về đêm của Đà Nẵng thì bạn nên đến Sky Bar cao nhất Việt Nam tại tầng 36 của khách sạn Novotel Đà Nẵng, giá cả cũng rất phải chăng với nhiều loại thức uống được phục vụ. 
<h3>Đến Đà Nẵng mua gì về làm quà?</h3> 
Bạn có thể mua các loại hải sản tươi sống hoặc khô như mực, tôm, cá khô tẩm tại chợ Cồn hay chợ Hàn…Các loại bánh tré Bà Đệ, rong biển Mỹ Khê, nước nắm Nam Ông…là những món quà đặc sản du khách thường mua về làm quà khi tới Đà Nẵng. 
<h3>Những điều lưu ý</h3> 
Tháng 10-12 Đà Nẵng (và miền Trung) bắt đầu vào mùa mưa, bão nên không thuận lợi cho các bạn di chuyển, nếu đến Đà Nẵng lúc này gần như chỉ có thể trải nghiệm cảm giác mưa bão miền Trung kết hợp với tour khám phá ẩm thực Đà Nẵng mà thôi. Nhớ là mưa miền Trung khá dai bạn nhé có thể kéo dài từ sáng đến chiều và từ tháng này qua tháng nọ. Và bạn nên nhớ là người dân Đà Nẵng rất nhiệt tình và hiếu khách nên muốn hỏi đường đi thì bạn đừng ngần ngại nhé, họ rất sẵn lòng và chỉ dẫn tận tình. 
</pre>' WHERE (`id` = '5');
