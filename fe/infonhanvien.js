document.addEventListener('DOMContentLoaded', async function () {
    // Giả sử email và password đã được xác định ở đâu đó
   //const email = '20521092@gm.uit.edu.vn'; 
   const email = sessionStorage.getItem("user");
   console.log(email);
    //const password = 'kfgoqxoh';
    //const email = req.session.email; 
    //const password = req.session.password;

    try {
        const response = await fetch('/infonhanvien', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({email})
        });

        const userData = await response.json();
        //console.log(userData.account.loaive);
        if (userData.account) {
            document.getElementById('hoten').textContent = userData.account.hoten;
            document.getElementById('gioitinh').textContent = userData.account.gioitinh;
            document.getElementById('ngsinh').textContent = userData.account.ngsinh;
            document.getElementById('diachi').textContent = userData.account.diachi;
            document.getElementById('quequan').textContent = userData.account.quequan;
            document.getElementById('sdt').textContent = userData.account.sdt;
            document.getElementById('vaitro').textContent = userData.account.vaitro;
            document.getElementById('diadiem').textContent = userData.account.diadiem;
        } else {
            console.error('Không có dữ liệu');
        }
    } catch (error) {
        console.error('Đã xảy ra lỗi:', error);
    }
});