const xeraForm = document.getElementById('xeraForm');
xeraForm.addEventListener('submit', async (event) => {
    event.preventDefault();  // Ngăn không cho form thực hiện hành động mặc định khi gửi

    const mand = document.getElementById('mand').value;
    const mathekvl = document.getElementById('mathekvl').value;
    const biensoxe = document.getElementById('biensoxe').value;
    const mabaidoxe = document.getElementById('mabaidoxe').value;

    // Kiểm tra nếu không có mã người dùng và mã thẻ khách vãng lai
    if (!mand && !mathekvl) {
        alert("Vui lòng nhập mã người dùng hoặc mã thẻ khách vãng lai.");
        return;
    }

    // Cố gắng gửi dữ liệu lên server thông qua API
    try {
        const response = await fetch('/submit-xera', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({
                mand: mand,
                mathekvl: mathekvl,
                biensoxe: biensoxe || null,  // Gửi null nếu không nhập biển số xe
                mabaidoxe: mabaidoxe
            })
        });

        const data = await response.json();  // Đọc phản hồi từ server dưới dạng JSON

        // Thông báo cho người dùng và điều hướng nếu thành công
        alert(data.message);
        if (data.success) {
            window.location.href = 'Thongtinxera.html';  // Điều hướng lại trang nếu cập nhật thành công
        }
    } catch (error) {
        // Xử lý nếu có lỗi từ phía server hoặc mạng
        console.error('Error:', error);
        alert('Đã xảy ra lỗi khi thêm xe ra. Vui lòng kiểm tra kết nối mạng hoặc liên hệ bộ phận hỗ trợ.');
    }
});