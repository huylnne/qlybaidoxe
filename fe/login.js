document.getElementById('loginForm').addEventListener('submit', async (event) => {
    event.preventDefault(); // Ngăn chặn hành động mặc định của form

    const email = document.getElementById('email').value;
    const password = document.getElementById('password').value;

    try {
        const response = await fetch('/login', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({ email, password })
        });

        const data = await response.json();

        if (data.success) {
            sessionStorage.setItem("user", data.account.email);
            if (data.account.vaitro === "Nhan vien") {
                window.location.href = '/dashboard'; // Chuyển hướng khi là nhân viên
            } else if (data.account.vaitro === "Khach hang") {
                //console.log("Khach hang");
                window.location.href = 'infokhachhang.html'; // Chuyển hướng khi là khách hàng
            }
        } else {
            alert('Email hoặc mật khẩu không đúng');
        }
    } catch (error) {
        console.error('Lỗi:', error);
        alert('Đã xảy ra lỗi khi đăng nhập');
    }
});

document.querySelector('.register-button').addEventListener('click', () => {
    window.location.href = 'dangkytaikhoan.html'; // Chuyển hướng đến trang đăng ký
});
