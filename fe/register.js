const registrationForm = document.getElementById('registrationForm');
        registrationForm.addEventListener('submit', async (event) => {
            event.preventDefault(); // Ngăn chặn form submit mặc định

            // Lấy dữ liệu từ form
            const email = document.getElementById('email').value;
            const password = document.getElementById('password').value;
            const fullName = document.getElementById('fullName').value;
            const gender = document.getElementById('gender').value;
            const dob = document.getElementById('dob').value;
            const address = document.getElementById('address').value;
            const hometown = document.getElementById('hometown').value;
            const phoneNumber = document.getElementById('phoneNumber').value;
            const role = document.getElementById('role').value;

            // Gửi dữ liệu đến server
            try {
                const response = await fetch('/register', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json'
                    },
                    body: JSON.stringify({
                        email: email,
                        password: password,
                        fullName: fullName,
                        gender: gender,
                        dob: dob,
                        address: address,
                        hometown: hometown,
                        phoneNumber: phoneNumber,
                        role: role
                    })
                });

                const data = await response.json();

                if (data.success) {
                    // Xử lý thành công, ví dụ: hiển thị thông báo, chuyển hướng trang...
                    alert("Đăng ký thành công!");
                    // Chuyển hướng đến trang đăng nhập chẳng hạn
                    window.location.href = 'index.html';
                } else {
                    // Xử lý lỗi, ví dụ: hiển thị thông báo lỗi
                    alert(data.message);
                }
            } catch (error) {
                console.error('Lỗi:', error);
                alert('Đã xảy ra lỗi khi đăng ký');
            }
        });