# Antigravity Multi-Agent Loop & Frontier Refinement (Windows Edition)

Bộ đóng gói kiến trúc **Agent Loop + Multi-Agent Orchestration** với cơ chế **Frontier Critic-in-the-Loop** chuyên trị các bài toán phức tạp trên môi trường Windows (PowerShell & Antigravity CLI).

---

## 💡 Nguồn Gốc Ý Tưởng & Vì Sao Bạn Nên Dùng Kiến Trúc Này?

### 🔴 Nỗi đau thực tế: Quota của Frontier Model quá ít!
Các mô hình AI đỉnh cao hàng đầu thế giới (Frontier Models như **Argon 4**, **Claude 3.5 Opus / Sonnet**, **GPT-4o / o1**) sở hữu khả năng tư duy logic và kiến trúc vượt trội. Tuy nhiên, rào cản lớn nhất đối với lập trình viên là **giới hạn Rate Limit & Hạn ngạch (Quota) cực kỳ eo hẹp**:
- Chỉ cần đưa một nhiệm vụ lớn (quét mã nguồn, tìm log lỗi, sửa hàng chục file I/O...), chỉ sau **1-2 prompt** là bạn đã bị chặn vì chạm trần Quota giới hạn trong ngày/giờ.
- Dùng một model Frontier đắt đỏ chỉ để làm những việc cơ bản như: đọc từng file, chạy regex, gõ từng dòng lệnh terminal là sự **lãng phí tài nguyên khủng khiếp**.

### 🟢 Giải pháp: Kiến trúc Bất đối xứng (Asymmetric Multi-Agent Architecture)
Kiến trúc này sinh ra để giải quyết triệt để bài toán *"Dùng Frontier Model mà không bị cạn Quota"*:

1. **Giao việc nặng nhọc cho "Cửu vạn tốc độ cao" (`@code-worker` chạy Flash 3.8 / Flash-Lite):**
   - Hạn ngạch bao la, tốc độ phản hồi tính bằng mili-giây.
   - Chuyên trách đọc hàng chục file codebase, trích xuất logs, gõ code thô, chạy tests trong terminal. Tiết kiệm **95% lượng token tiêu thụ** cho hệ thống.
2. **Tiết kiệm Quota Frontier Model cho các bước "Ra quyết định tối thượng":**
   - **`@architect-lead` (Opus 5.5)**: Chỉ xuất hiện đúng 1 lần ở bước đầu để chốt bản thiết kế kiến trúc chuẩn xác nhất (`ARCH_PLAN.md`).
   - **`@architect-reviewer` (Argon 4)**: Đóng vai trò chánh thanh tra, chỉ nhận bản tóm tắt diff và log test để soi lỗ hổng, bảo mật và logic quan trọng.
3. **Hiệu quả:** Bạn vừa sở hữu sức mạnh trí tuệ của các model đắt giá nhất hành tinh, vừa bảo toàn được Quota để làm việc cả ngày mà không lo bị chặn!

---

## 🌟 Điểm nổi bật trong kiến trúc

1. **Phối hợp đa tác tử theo chuyên môn:**
   - `@code-worker`: Thu thập bối cảnh codebase, logs, hiện trạng (`SPEC_DIGEST.md`), sau đó băm nhỏ việc và trực tiếp viết mã/test.
   - `@architect-reviewer`: Phản biện, bới móc edge cases, bảo mật, nghẽn hiệu năng (`SPEC_FEEDBACK.md`) và trực tiếp thẩm định diff code.
   - `@architect-lead`: Chốt thiết kế kiến trúc toàn diện (`ARCH_PLAN.md`).
2. **Actor-Critic Refinement Loop (Vòng lặp sửa lỗi tự động):**
   - `@code-worker` tạo kết quả sơ bộ kèm test $\rightarrow$ **Frontier Reviewer** kiểm duyệt.
   - Nếu còn lỗi, Reviewer đưa checklist chỉ thị cho `@code-worker` sửa lại. Vòng lặp tiếp tục cho đến khi đạt `STATUS: APPROVED` (tối đa 3 vòng lặp để chặn tốn token).
3. **Báo cáo tổng kết & Gợi ý tối ưu (`SESSION_LOG.md`):**
   - Tóm tắt module đã sửa, các bug đã giải quyết qua từng vòng, trạng thái test, và đưa ra 2-3 hướng tối ưu tiếp theo để người dùng quyết định.
4. **Cơ chế Dynamic Model Tiers:**
   - Dễ dàng thay đổi model cho từng agent theo cấu hình định sẵn hoặc tùy chỉnh tự do.

---

## ⚙️ Cấu hình Model mặc định của Repo (Frontier Hybrid)

| Subagent | Vai trò | Model Mặc định | Đặc điểm & Nhiệm vụ |
| :--- | :--- | :--- | :--- |
| **`@code-worker`** | Worker & Context Collector | **Gemini 3.8 Flash** | Tốc độ cực nhanh, quota dồi dào, gánh toàn bộ file I/O & terminal test |
| **`@architect-reviewer`**| Frontier Critic & Code Reviewer | **Argon 4** | Khả năng phản biện, soi lỗi logic đỉnh cao, chỉ thẩm định bản diff tinh gọn |
| **`@architect-lead`** | Lead Systems Architect | **Opus 5.5** | Tư duy kiến trúc vững chắc, chốt thiết kế tổng thể mà không tốn quota chạy vặt |

---

## 🚀 Hướng dẫn Cài đặt & Sử dụng

Mở **PowerShell** (Run as Administrator hoặc thường):

```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
cd antigravity-agent-loop-windows
.\install.ps1
```
*Script sẽ tự động cài đặt cấu hình mặc định: **Code Worker (Flash 3.8)** + **Reviewer (Argon 4)** + **Lead (Opus 5.5)**.*

### Đổi gói cấu hình khác (Nếu cần):
- **Gói Auto-detect (Tự nhận theo gói tài khoản người dùng):**
  ```powershell
  .\install.ps1 -Tier auto
  ```
- **Gói Tiết kiệm (Starter / Flash):**
  ```powershell
  .\install.ps1 -Tier starter
  ```
- **Gói Cân bằng chuẩn (Pro):**
  ```powershell
  .\install.ps1 -Tier pro
  ```

---

## 🛠️ Hướng dẫn Người dùng Tự Tùy Chỉnh Agent & Model

### 1. Thay đổi Model cho từng Agent
Người dùng có thể mở tệp cấu hình tại:  
`C:\Users\<Tên_User>\.gemini\config\agent-loop\model_tiers.json`

Có thể sửa trực tiếp bất kỳ model nào bạn thích:
```json
{
  "active_tier": "frontier_custom",
  "max_refinement_loops": 3,
  "tiers": {
    "frontier_custom": {
      "worker_model": "flash",
      "reviewer_model": "Argon 4",
      "lead_model": "Opus 5.5"
    }
  }
}
```

### 2. Thêm hoặc Sửa Quyền Hạn / Vai trò của Subagent
Tất cả subagent được định nghĩa bằng file JSON tại thư mục `agents/`:
- `code-worker.json`: Có các công cụ đọc/chỉnh sửa file và chạy lệnh terminal (`execute_command`, `file_edit`).
- `architect-reviewer.json` & `architect-lead.json`: Chỉ có công cụ đọc (`view_file`, `search_web`), an toàn tuyệt đối, không thay đổi file hay chạy lệnh lạ.

---

## ❓ Giải đáp: Khi gõ `/plan` và `/goal` có phải bấm Permission không?

### 1. Khi dùng lệnh `/plan`:
- Lệnh `/plan` được thiết kế theo quy chuẩn an toàn **Plan-First**.
- Sau khi khảo sát và tạo ra tài liệu kế hoạch, Agent **chủ ý dừng lại** và yêu cầu người dùng bấm duyệt (Proceed) trước khi đụng vào code. Đây là tính năng bảo vệ an toàn giúp bạn kiểm soát hoàn toàn mã nguồn.

### 2. Khi dùng lệnh `/goal`:
- Lệnh `/goal` chạy theo chế độ **Autonomous Long-running Task (Nhiệm vụ tự vận hành)**.
- **Để hệ thống chạy mượt mà không bị dừng lại hỏi quyền terminal/edit:**
  Người dùng có thể bật chế độ Auto-Approve trong Antigravity CLI bằng cách thêm cờ khi khởi động hoặc cấu hình trust workspace:
  ```bash
  agy --auto-approve
  ```
  Khi đó, `@code-worker` và các subagent sẽ tự động chạy xuyên suốt quy trình từ phân tích $\rightarrow$ code $\rightarrow$ test $\rightarrow$ sửa lỗi cho tới khi hoàn tất 100%!

---

## 🗑️ Gỡ bỏ cài đặt (Uninstall)

```powershell
.\uninstall.ps1
```
