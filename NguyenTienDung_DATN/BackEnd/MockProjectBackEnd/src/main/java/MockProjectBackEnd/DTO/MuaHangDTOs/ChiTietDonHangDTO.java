package MockProjectBackEnd.DTO.MuaHangDTOs;

import lombok.Data;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Data
@NoArgsConstructor
public class ChiTietDonHangDTO {

    private Integer maSanPham;

    private String tenSanPham;

    private String anhMinhHoa;

    private Integer donGia;

    private Integer soLuong;

    private Integer thanhTien;

}
