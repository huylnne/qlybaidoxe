document.addEventListener('DOMContentLoaded', function() {
    const form = document.querySelector('form'); 

    form.addEventListener('submit', async (event) => {
        event.preventDefault(); 

        const sdt = document.getElementById('sdt').value;
        const maloaive = document.getElementById('maloaive').value;
        const soluongve = document.getElementById('soluongve').value; // Sửa đổi ID này cho phù hợp với HTML
        //console.groupCollapsed()
        console.log('Sending data:', {sdt, maloaive, soluongve }); // Kiểm tra dữ liệu được gửi

        try {
            const response = await fetch('/dangkymuave', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify({
                    sdt: sdt,
                    maloaive: maloaive,
                    soluongve: soluongve
                })
            });

            const data = await response.json();
            console.log('Server response:', data); // Kiểm tra phản hồi từ server

            if (data.success) {
                alert("Đăng ký vé thành công");
                window.location.href = 'Thongtinxevao.html';
            } else {
                alert(data.message);
            }
        } catch (error) {
            console.error('Lỗi:', error);
            alert('Đã xảy ra lỗi khi đăng ký vé');
        }
    });
});