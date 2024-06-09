document.addEventListener('DOMContentLoaded', function () {
    const form = document.querySelector('form'); // Giả sử chỉ có một form trên trang này

    form.addEventListener('submit', async (event) => {
        event.preventDefault(); // Ngăn chặn form submit mặc định

        // Lấy dữ liệu từ form
        const mand = document.getElementById('mand').value;
        const maLoaiVe = document.getElementById('tenloaive').value; // Sửa đổi ID này cho phù hợp với HTML
        const soluongve = document.querySelector('input[type="text"]').value; // Giả sử đây là input cho số lượng vé

        // Gửi dữ liệu đến server
        try {
            const response = await fetch('/dangkyve', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify({
                    mand: mand,
                    maLoaiVe: maLoaiVe,
                    soluongve: soluongve
                })
            });

            const data = await response.json();

            if (data.success) {
                // Xử lý thành công, ví dụ: hiển thị thông báo, chuyển hướng trang...
                alert("Đăng ký vé thành công");
                // Chuyển hướng đến trang thông tin xe vào
                window.location.href = 'Thongtinxevao.html';
            } else {
                // Xử lý lỗi, ví dụ: hiển thị thông báo lỗi
                alert(data.message);
            }
        } catch (error) {
            console.error('Lỗi:', error);
            alert('Đã xảy ra lỗi khi đăng ký vé');
        }
    });
});

