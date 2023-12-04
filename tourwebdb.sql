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
  max_number_tourist int not null,
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
  tourist_number int not null,
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
  PRIMARY KEY (user_id, tour_id)
);

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
INSERT INTO post(user_id, content, post_date)
VALUES (3, '<pre><h1>Du lịch Đà Lạt, mùa nào đẹp?</h1>
Nổi tiếng với khí hậu mát mẻ, ôn hòa và thêm chút se se lạnh của mình, Đà Lạt dường như là điểm chẳng bao giờ lọt ra khỏi danh sách du lịch của các bạn trẻ. Nhưng không hẳn, bất cứ ai, bất cứ thời gian nào Đà Lạt cũng đều mang đến cho bạn những tấm ảnh đẹp. Vậy du lịch Đà Lạt, mùa nào đẹp đây? Mùa nào thì mới cho bạn những tấm ảnh đẹp nhỉ?
    
<h2>1. Thời tiết của thành phố Đà Lạt:</h2>
Là một thành phố thuộc tỉnh Lâm Đồng, Đà Lạt tọa lạc trên cao nguyên Langbiang, phía Nam cao nguyên Lâm Viên. Nên nơi đây cũng sẽ mang những đặc tính khí hậu khác với nhiều nơi.
Mặc dù cùng một khu vực đi nữa thì thời tiết Đà Lạt cũng có sự khác biệt so với các tỉnh trong khu vực Tây Nguyên. Nguyên nhân được cho rằng là bởi vì Đà Lạt nằm trên địa hình cao, có khí hậu ôn hòa, mát mẻ.
Đà Lạt có lạnh nhưng không lạnh rét buốt như ở miền Bắc, mà nó se se lạnh một chút mang lại cảm giác rất dễ chịu.
Có lẽ vì thế nên Đà Lạt luôn tràn ngập những loài hoa, những loại rau khác nhau.
    
<h2>2. Du lịch Đà Lạt, mùa nào đẹp?</h2><h3>- Du lịch Đà Lạt mùa xuân: từ tháng 1-> tháng 4</h3>
Mùa xuân ở Đà Lạt rơi vào khoảng thời gian từ tháng 1 đến tháng 4 hàng năm, đến đây vào dịp này bạn sẽ có cơ hội chiêm ngưỡng những loài hoa đặc trưng của thành phố. Đặc biệt, mọi con đường ở Đà Lạt vào thời gian này đều rực rỡ sắc màu của hoa mai anh đào.
Địa điểm bạn có thể ngắm hoa mai anh đào: Đường Trần Hưng Đạo hoa mai anh đào nở rộ hai bên đường dọc theo dãy biệt thự cổ Cadasa; Đường Lê Đại Hành ngay trung tâm thành phố đường ven Hồ Xuân Hương và Thiền Viện Trúc Lâm,...
<h3>- Du lịch Đà Lạt mùa hạ: từ tháng 3 đến tháng 5</h3>
Đà Lạt vào mùa hạ lại tràn ngập sắc màu của hoa phượng tím, khoảng thời gian từ tháng 3 đến tháng 5. Không chỉ mang một màu tím ấn tượng, loài hoa này còn mang đến cho Đà Lạt một không gian thơ mộng đầy sự lãng mạn, có những lúc lại thêm một chút man mác buồn.
Khoảng thời gian từ tháng 8 đến tháng 10 thì Đà Lạt thường có mưa to. Bạn cũng có thể ngồi nhâm nhi ly cà phê nóng, hoặc ngồi trong những căn Homestay xinh xắn, view toàn cảnh Đà Lạt trong cơn mưa, cũng lãng mạn phết đấy chứ nhỉ.
<h3>- Du lịch Đà Lạt mùa cuối thu đầu đông: từ tháng 10-> tháng 12</h3>
Vào khoảng thời gian từ tháng 10 đến tháng 12, Đà Lạt đang vào dịp cuối thu đầu đông, không khí se se lạnh. Đặc biệt, khoảng thời gian này có loài hoa dã quỳ nở rộ tuyệt đẹp.
Bạn có thể chiêm ngưỡng loài hoa này ở: Đường đi Tà Nung, Suối Thông hoa, đường đi Hàm Thuận (Bảo Lộc, Lâm Đồng), đèo Hiệp Phú (Di Linh, Lâm Đồng),...
Tùy vào sở thích, bạn có thể tự lựa chọn thời gian du lịch cho bản thân. Chắc bạn cũng có câu trả lời cho câu hỏi DU LỊCH ĐÀ LẠT, MÙA NÀO ĐẸP rồi phải không?
Du lịch Đà Lạt, mùa nào đẹp? Phải kể đến đó chính là khoảng thời gian đầu tháng 11 tới tháng 3, khi mà cuối thu chớm đông và mùa xuân bắt đầu. Khi đó, vào cuối tháng 10, đầu tháng 11 hoa dã quỳ nở, tiếp đó tháng 1-2 mùa xuân hoa mai anh đảo nở, cùng nhiều loại hoa khác nhau nữa.
Đặc biệt, 2 năm Đà Lạt sẽ tổ chức một kì Festival hoa tổ chức hai năm một lần vào các năm chẵn tại các dịp giáp Tết. Nếu thích không khí sôi động thì bạn nên lui tới Đà Lạt vào dịp cuối tuần, vào dịp diễn ra Festival ấy.
    
<h2>3. Vậy du lịch Đà Lạt, không nên đi mùa nào?</h2>
Nhưng cũng là mùa hè, nếu lên Đà Lạt vào khoảng thời gian từ tháng 8 đến tháng 10 thì bạn sẽ thường xuyên gặp phải những cơn mưa to. Nếu không muốn kế hoạch đi chơi bị hủy kèo, hoặc bị ướt đồ thì bạn nên né khoảng thời gian này ra nhé.
Với những mốc thời gian chính, kèm với vẻ đẹp của từng mùa chi tiết trên này, chắc bạn biết nên Du lịch Đà Lạt, mùa nào đẹp rồi chứ.
</pre>', '2023-12-14 12:32:40'),

(4, '<pre><h1>KINH NGHIỆM SĂN HOA MAI ANH ĐÀO ĐÀ LẠT</h1>
Mai anh đào ở Đà Lạt rất đặc biệt, thân cây tựa như giống đào mân còn hoa thì giống hoa mai. Theo một số nghiên cứu thì Mai anh đào có nguồn gốc từ nước ngoài và được trồng tại Đà Lạt. Và Đà Lạt tháng 1 là thời điểm Mai anh đào bung nở đẹp nhất, kinh nghiệm săn mai anh đào Đà Lạt sau đây sẽ gợi ý giúp bạn thưởng thức 1 mùa Mai anh đào đang đến.

<h2>MÙA MAI ANH ĐÀO NỞ ĐẸP NHẤT</h2>
Hoa mai anh đào Đà Lạt có nguồn gốc rất đặc biệt với thân cây thì giống đào mận còn hoa thì lại có năm cánh giống hoa mai. Chính vì nửa mai nửa đào như vậy nên cái tên Mai Anh Đào ra đời.
Theo các nhà nghiên cứu thì mai anh đào có nguồn gốc từ Đà Lạt tuy nhiên cũng có một số ý kiến cho rằng đây là loài hoa được nhập từ nước ngoài và chỉ trồng ở khu vực thành phố Đà Lạt.
Mai anh đào ở Đà Lạt vào đầu mùa khô (tháng 10 hằng năm) lá vàng dần và rụng, trơ trội cành lá khẳng khiu ngủ đông. Mãi cho đến khi đất trời Đà Lạt chuyển mùa, tầm giữa tháng 1 thì lúc ấy cây Mai anh đào mới “bừng dậy” nở hoa mạnh mẽ nhất báo hiệu xuân đang về.
Vào mùa Mai anh đào nở, Mai anh đào thường nở đồng loạt, chi chít từ gốc đến ngọn. Lúc này cả Đà Lạt như ngập tràn trong sắc hồng của Mai anh đào. tại sức cuốn hút, ngất ngây đến lạ.

<h2>NHỮNG CUNG ĐƯỜNG NGẮM MAI ANH ĐÀO TẠI ĐÀ LẠT</h2><h3>+ Đường Mai anh đào - Trần Hưng Đạo:</h3>
Đường Trần Hưng Đạo còn được gọi là đường hoa Mai anh đào của Đà Lạt. Đoạn đường kéo dài hơn 500m được trồng hai hàng hoa Mai anh đào hai bên đường. Sự kết hợp hài hòa giữa hàng thông già nghiêm bóng, những dãy biệt thự cổ kính hai bên cùng với màu hồng thắm của sắc hoa Đào đã tạo nên một con đường thật quyến rũ.
<h3>+ Mai anh đào Đà Lạt quanh Hồ Xuân Hương:</h3>
Hồ Xuân Hương có vị trí nằm ngay trung tâm thành phố nên hầu như ai cũng biết điểm này. Đoạn có nhiều Mai anh đào Đà Lạt nhất là đoạn đường gần với nhà hàng Thủy Tạ và đoạn gần nhà hàng – cafe Bích Câu. Hiện nay, người ta đang trồng thêm rất nhiều cây Mai anh đào, chỉ vài năm nữa thôi, hoa Mai anh đào Đà Lạt sẽ nở hồng một vùng hồ.
<h3>+ Rừng Mai anh đào Hồ Tuyền Lâm:</h3>
Đoạn này hơi khó tìm chút xíu, nên bạn phải để ý kĩ. Trên đường đi đường hầm điêu khắc, đi qua khỏi cây cầu sắt, bạn chạy chậm và để ý nhìn xuống phía hồ bạn sẽ thấy một cụm hoa Mai anh đào lớn.
<h3>+ Mai anh đào Dốc Đa Quý:</h3>
Đây hứa hẹn là điểm hấp dẫn nhất và “rực rỡ nhất” đó chính là Dốc Đa Quý ở Trại Mát. Đây là đoạn đường hoa Mai anh đào nở nhiều và đẹp, được nhiều người săn đón. Vào mùa Mai anh đào nở, khi đến đây bạn sẽ thấy rất nhiều người.
Mai anh Đào không chỉ là niềm tự hào của mọi con người Đà Lạt mà nó còn là những kỷ niệm không thể nào phai nhạt của du khách khi may mắn được đặt chân tới thành phố Đà Lạt đúng mùa hoa nở.
Mùa Mai anh đào Đà Lạt đang kéo đến, cũng trùng vào dịp Tết Nguyên Đán tại Việt Nam, dắt tay người yêu, bạn bè hay gia đình để làm ngay một album ảnh chuẩn style Nhật Bản hay Hàn Quốc tại ngay Đà Lạt nào, và đừng quên mang theo máy ảnh hay điện thoại để ghi lại những khoảnh khắc Mai anh đào nở tuyệt đẹp.
</pre>', '2023-12-14 15:40:03'),

(5,	'<pre><h1>Hành trình 3 ngày 2 đêm lênh đênh trên đảo Cô Tô</h1>
ĐI CÔ TÔ ĂN - CHƠI - Ở ĐÂU?
Hành trình 3 ngày 2 đêm lênh đênh trên đảo ?
Mình đã từng ao ước được ra Cô Tô khi còn là một cậu học sinh ngồi trên ghế nhà trường qua bài kí của Nguyễn Tuân. Một chuyến đi mà tưởng chừng như sẽ mãi nằm trên sách vở, và sau nhiều trắc trở cuối cùng mình cũng đã đạt mục tiêu đặt chân lên đảo.
Lịch trình và chi phí của tụi mình như sau, các bạn cùng tham khảo nhé:
? Ở đâu
    Tụi mình ở nhà nghỉ Khang Tính, điểm cộng là cô chủ nhà cực kì niềm nở, phòng ốc thì sạch sẽ, bình nóng lạnh hay điều hòa cũng đầy đủ luôn nha.
    Nhà nghỉ tụi mình ở ngay sát trung tâm. Cách bãi Tình Yêu có hơn 1km, Vàn Chảy khoảng 5km. Còn Hồng Vàn thì xa nhất, khoảng hơn 7km. Bãi Hồng Vàn là xa trung tâm thị trấn nhất.
    + Nhà nghỉ: 250k/phòng 2 giường/ngày x 2
    => Tổng: 500k
? Về di chuyển
1/ Từ Hải Phòng - cảng Cái Rồng (mọi người cứ gg mapp là ra)
    Tụi mình đi 2 người và di chuyển bằng xe máy. Xuất phát lúc 8h và 11h tụi mình đã có mặt tại cảng Cái Rồng. Đường quốc lộ 18 khá dễ đi, tuy nhiên sẽ có chốt bắn tốc độ ở gần trạm thu phí Đại Yên nên mọi người cứ nhẹ tay lái thôi nha.
    + Xăng: 250k (cả đi và về)
2/ Từ cảng Cái Rồng - Cô Tô
    Có hai loại tàu để chọn lựa khi di chuyển từ cảng Cái Rồng, Vân Đồn ra đảo Cô Tô: Tàu gỗ và tàu cao tốc.
    Tụi mình chọn đi tàu cao tốc của hãng Quang Minh (30p sẽ có một chuyến). Tàu chạy rất êm và đúng giờ, khoang hành khách sạch sẽ. Theo mình mọi người nên ra ngoài đuôi tàu cho thoáng vì bên trong khoang khá nóng. Tàu chạy khoảng chừng 1 tiếng rưỡi là đến nơi.
    + Vé tàu: 250k/người/chiều x2
3/ Di chuyển trên đảo
    Tụi mình thuê xe máy của nhà nghỉ Khang Tính luôn, ngoài ra nếu các bạn đi đông thì có thể thuê xe điện. Các cô chú đều rất nhiệt tình, hầu như gọi chỉ cần vài phút là có mặt.
    + Xe máy: 100k/ngày x2
    + Xăng: 50k
    => Tổng: 1.000k
? Ăn uống - ngày 1
1/ Ăn sáng:
    + Tự túc ở nhà: free
2/ Ăn trưa:
    + Sandwich (mua ở Aeon Mall): 40k
    + Bánh ngọt: 20k
    + Bánh mỳ trứng: 15k
3/ Ăn tối:
    + Cơm niêu: 40k/người x2
4/ Ăn vặt, cà phê:
    + Kem xôi: 30k/cốc x2
    Cơm niêu ở đây ngon, rẻ, nhưng không đặc biệt, kiểu như cơm nhà thôi. Ăn vặt, cafe ở CoTo rất chất lượng mà siêu rẻ, chả bù cho ly nhựa Highlands vừa tăng giá ?.
    ?Note: Cafe ở CoTo hay đóng cửa “ngủ sớm”, mn tìm chỗ cà kê thì nhớ check kĩ nha. Ngoài ra ở đây cũng không có bar hay pub, sau 10h đường sẽ rất vắng (nhưng đây lại là một điểm mình khá thích)
? Ăn uống - ngày 2
1/ Ăn sáng:
    + Mì hộp: 10k/người x2
2/ Ăn trưa
    + Cơm rang: 35k/người x2
3/ Ăn tối
    + Cơm hàng: 40k/người x2
4/ Ăn vặt, cà phê:
    + Coctail: 60k/cốc x2 (bù lại được ngắm biển đêm, khá chill)
    Các bữa trưa và tối tụi mình đều ăn ở quanh thị trấn. Nói chung là đầy đủ nhưng khá chán. Có buổi trưa ở tụi mình ăn no để đi chơi, nhưng no quá lúc xuống bãi biển không đi nổi luôn.
? Ăn uống - ngày 3
1/ Ăn sáng:
    + Bánh mỳ thịt: 20k/người (bạn mình tiếp tục ăn mỳ hộp)
2/ Ăn trưa:
    + Phở bò: 30k/bát
    + Cơm rang: 40k/đĩa
    => Tổng: 595k
?Lịch trình
?NGÀY 1: Bãi Hồng Vàn - Cầu Gỗ - phố đi bộ Ký Con
    - Bọn mình đến nhà nghỉ lúc 13h30: được cô chú cho check in sớm. Tụi mình nghỉ ngơi chút, chiều lấy xe máy và đi tham quan các điểm.
    + Bãi Hồng Vàn:
    Tụi mình ra bãi Hồng Vàn tắm biển, nước có màu xanh ngọc, cát mịn, tắm rất thích, mình đi hôm mùng 2/5 thì bãi khá vắng, hầu như không có ai ngoài 2 đứa tụi mình. Với một tay nghiện sống ảo như tui thì đây đúng là điều tuyệt vời.
    + Cầu gỗ:
    Đường tới cầu gỗ khá xa nhưng bù lại cảnh đẹp, bình yên cực. Ở đây chụp đẹp nhất là nên đi buổi chiều sẽ săn được hoàng hôn, nếu đi buổi sáng ảnh chụp sẽ bị ngược sáng và không lấy được view biển. Vì là cầu gỗ nên đi trên cầu khá chông chênh, mọi người nên đi vào giữa cầu tránh bám vào thành cầu kẻo ngã xuống biển nha.
?NGÀY 2: Bãi đá Móng Rồng - Hải Đăng Cô Tô - Âu Cảng - con đường tình yêu - bãi Vàn Chảy - bãi biển tình yêu
    Sáng bọn mình đón bình minh trên biển Hồng Vàn, khoảng từ 5h30-6h mặt trời lên, tầm này có chút se lạnh nên bạn nào có ý định tắm biển thì lưu ý nha.
    + Bãi đá Móng Rồng:
    Muốn ra bãi đá Móng Rồng các bạn nên đi từ rất sớm nhé. Vì mình không muốn bỏ lỡ khoảng khắc đẹp nhất trong ngày này nên đã xuất phát từ ... 6h sáng (do tối hôm trước tụi mình thức muộn tâm sự về cuộc đời) . Chỗ này cách trung tâm khoảng 3km thôi mà ai đã ra Cô Tô nhất định đều phải ghé qua.
    Ở đây vẫn còn chưa hoàn thiện nên rất hoang sơ, nhưng bạn nào muốn một lần ngắm nhìn trọn vẹn đảo thì nên chịu khó trèo lên nhưng mỏm đá cao. Nhưng đi cẩn thận vì đá hơi trơn, đừng để bị cứa vào chân như mình.
    Gửi xe: 5k/xe
    + Hải Đăng Cô Tô:
    Hải Đăng Cô Tô có thể nói là một nơi tuyệt vời nhất nếu muốn ngắm trọn hòn đảo xinh đẹp này. Đường lên đây tương đối dốc, mọi người nên chọn phóng thẳng xe máy lên hoặc đi xe điện. Đây không phải điểm tham quan du lịch mà là nơi làm việc nên khi chụp ảnh chú ý đi lại nhẹ nhàng để tránh làm phiền tới mọi người
    xung quanh.
    Gửi xe: 10k/xe
    + Âu Cảng:
    Ở đây cảnh khá đẹp, tuy nhiên mình thấy khá giống đê chắn sóng ở Cát Hải. Vì có ảnh tựa như thế rồi nên mình chỉ ghé qua rồi sang con đường tình yêu luôn.
    + Con đường tình yêu:
    Gọi là con đường tình yêu vì ở đây có một lối đi bên là hàng cây thông, bên còn lại là bãi biển Tình yêu. Điểm trừ là ở đây người ta xả hơi nhiều rác, chung lại là không mộng mơ như các bạn tưởng tượng đâu. Chớ dắt bồ ra đây để rồi mất công chửi nhau :v
    + Bãi Vàn Chảy:
    Cá nhân mình thích nhất bãi này, sóng đánh cực to, to nhất trong các bãi mình từng đi luôn, thích hợp cho một đứa thích va chạm với cuộc đời như mình :v
    + Bãi biển tình yêu:
    Trên đường về khách sạn mình có dừng lại để ngắm hoàng hôn, đối với mình đây là khoảnh khắc đẹp nhất của chuyến đi.
?NGÀY 3: Tạm biệt hòn đảo và ra về
    Mình check out lúc 7h30 sáng và tạm biệt mọi người để quay lại đất liền, kết thúc một chuyến đi hơn cả sự mong đợi.
    + Vé tàu: 250k/chiều về/người/ x2
    => Tổng: 565k
? TỔNG CỘNG: 2.660k (chia ra mỗi người 1.330k)
Lưu ý nhỏ trước khi đi Cô Tô:
    + Cân nhắc thời gian khi ra đảo, nên đi 3n2d vì nếu đi 2n1d sẽ rất gấp và mệt. Đặc biệt lưu ý thời tiết, nếu đi vào đúng ngày biển động sẽ rất dễ bị mắc kẹt lại trên đảo.
    + Chuẩn bị mọi loại thuốc chống say tàu vì tàu sẽ đi rất nhanh khiến bạn không kịp trở tay thay quần áo luôn.
    + Hải sản Cô Tô khá tươi và rẻ, mọi người có thể mua về làm quà hoặc ăn tại chỗ đều rất ok.
    + Đặc biệt lưu ý giờ tàu về, ngày thường chỉ có 2 đợt là 8h và 13h30, còn cuối tuần sẽ có chuyến tăng cường. Mọi người lưu ý nếu không muốn kẹt lại đảo như tụi mình.
    + Theo cảm nhận của riêng cá nhân mình, Cô Tô vẫn còn mang những nét hoang sơ, du lịch chưa được phát triển nhiều, phù hợp cho những ai muốn trải nghiệm và tìm một nơi để tĩnh dưỡng, không phù hợp lắm với những bạn thích ồn ào, bay lắc :v
MỌI NGƯỜI CÒN CHẦN CHỪ GÌ NỮA, HÈ NÀY ĐI CÔ TÔ THÔI!
</pre>', '2023-12-10 20:30:00'),

(6,	'<pre><h1>Bình minh trên biển Quan Lạn</h1>
? Săn bình minh trên biển : 
    - Địa điểm: Đảo Minh Châu - Quan Lạn, Quảng Ninh 
    - Thời gian : mình đi từ lúc 4h30 - 5h30 sáng. 
Đây là khoảng thời gian thích hợp để bạn có thể ngắm trọn khung cảnh mặt trời mọc và vẻ đẹp bình yên của nơi đây do thiên nhiên ban tặng. Nếu bạn đang tìm một điểm đến bình yên, trốn deadline một vài ngày hay đơn giản là khám phá trải nghiệm thì Quan Lạn là một cái tên rất đáng để bạn bỏ túi. Và nếu có dịp ghé nơi đây, bạn đừng bỏ lỡ khoảnh khắc ngắm bình minh trên biển nhé. Nó thật sự rất tuyệt ?
</pre>', '2023-12-05 19:37:43'),

(7, '<pre><h1>KHÁM PHÁ LÀNG LỤA VẠN PHÚC (HÀ ĐÔNG) HÀ NỘI</h1>
Lần đầu tiên đươc khám phá làng lụa Vạn phúc Hà Đông tôi thật sự ấn tượng về không giản rực rở sắc màu được làm từ các loại tơ tầm độc đáo...
Làng lua Vạn Phúc cách trung tâm Hà Nội 10km , không chỉ là một làng nghề truyền thống dệt lụa tơ tầm có lịch sử hàng nghìn năm mà nơi đây còn là một điểm du lịch nổi tiếng thu hút du khách trong và ngoài nước tấp nập tham quan mua sắm tạo nên một săc thái đậc trưng riêng
Đến làng Vạn Phúc bạn còn có thể ngắm nhìn lại những nét cổ kính như cổng làng, cây đa, giếng nước bụi tre ... thật là bình yên & thơ mộng .
Đến đây các bạn tha hồ lưa chọn các loại áo vải thời trang bằng lụa đủ màu, đủ kiểu hoàn toàn bằng chất liệu tơ tầm tuyệt đẹp về diện quanh năm nhé.
Nếu các bạn muốn chọn cho người thân một món quà xinh xắn và giá trị thì tại làng lụa Vạn phúc này sẽ có đủ loại cho các bạn chọn lựa vậy.
Nếu có dịp đi Hà Nội các bạn đừng quên ghé thăm làng Lụa Vạn Phúc nhé. Ngày nay có phương tiện tàu điện trên không từ Cát Lái đến Hà Đông cũng thật là tiện lợi vô cùng các bạn ạ.
</pre>', '2023-12-20 07:45:32');

-- Example data for comment
INSERT INTO comment(user_id, post_id, content, reply_date)
VALUES (4, 3, 'Mình cùng nhóm bạn đang định đi Cô Tô nhưng không biết lên lịch trình như nào thì đọc được bài viết của bạn. Cảm ơn vì sự chia sẻ của bạn.', '2023-12-14 18:25:45'),
	(8, 1, 'Đọc bài viết của bạn xong làm mình háo hức muốn đi Đà Lạt quá!!!', '2023-12-14 20:38:21'),
    (2, 2, 'Mai mình sẽ đi săn hoa mai anh đào Đà Lạt thử theo bài viết của bạn xem sao.', '2023-12-16 08:12:32');

SELECT * FROM available_tour;
SELECT * FROM account;
SELECT * FROM post;
SELECT * FROM comment;


