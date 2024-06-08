const xevaoForm = document.getElementById('xevaoForm');
        xevaoForm.addEventListener('submit', async (event) => {
            event.preventDefault(); // Ngăn chặn form submit mặc định

            // Lấy dữ liệu từ form
            const mand = document.getElementById('mand').value;
            const mathekvl = document.getElementById('mathekvl').value;
            const biensoxe = document.getElementById('biensoxe').value;
            const tenloaixe = document.getElementById('tenloaixe').value;
            const mabaidoxe = document.getElementById('mabaidoxe').value;

            // Gửi dữ liệu đến server
            try {
                const response = await fetch('/submit-xevao', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json'
                    },
                    body: JSON.stringify({
                        mand: mand,
                        mathekvl: mathekvl,
                        biensoxe: biensoxe,
                        tenloaixe: tenloaixe,
                        mabaidoxe: mabaidoxe
                    })
                });

                const data = await response.json();

                if (data.success) {
                    // Xử lý thành công, ví dụ: hiển thị thông báo, chuyển hướng trang...
                    alert("Thêm xe vào thành công");
                    // Chuyển hướng đến trang thông tin xe vào
                    window.location.href = 'Thongtinxevao.html';
                } else {
                    // Xử lý lỗi, ví dụ: hiển thị thông báo lỗi
                    alert(data.message);
                }
            } catch (error) {
                console.error('Lỗi:', error);
                alert('Đã xảy ra lỗi khi thêm xe');
            }
        });