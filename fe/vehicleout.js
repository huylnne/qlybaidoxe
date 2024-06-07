const xeraForm = document.getElementById('xeraForm');
        xeraForm.addEventListener('submit', async (event) => {
            event.preventDefault();

            const makh = document.getElementById('makh').value;
            const mathekvl = document.getElementById('mathekvl').value;

            if (!makh && !mathekvl) {
                alert("Vui lòng nhập mã khách hàng hoặc mã thẻ khách vãng lai.");
                return;
            }

            try {
                const response = await fetch('/submit-xera', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json'
                    },
                    body: JSON.stringify({
                        makh: makh,
                        mathekvl: mathekvl
                    })
                });

                const data = await response.json();

                if (data.success) {
                    alert(data.message);
                    window.location.href = 'Thongtinxera.html'; 
                } else {
                    alert(data.message);
                }
            } catch (error) {
                console.error('Error:', error);
                alert('Đã xảy ra lỗi khi thêm xe ra');
            }
        });