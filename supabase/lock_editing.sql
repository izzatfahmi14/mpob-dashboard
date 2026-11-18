-- Lock editing to signed-in staff (apply when the login version of the dashboard goes live).
-- Viewing stays public. Device uploads (harvest_data insert, gateway_status heartbeat) are NOT changed.
-- Staff = rows in public.staff (see is_staff()). Add a person with:
--   insert into public.staff(email,name) values ('someone@example.com','Name');

-- palm_trees
drop policy if exists "pt insert" on public.palm_trees;
drop policy if exists "pt update" on public.palm_trees;
create policy "pt insert staff" on public.palm_trees for insert to authenticated with check (public.is_staff());
create policy "pt update staff" on public.palm_trees for update to authenticated using (public.is_staff()) with check (public.is_staff());
create policy "pt delete staff" on public.palm_trees for delete to authenticated using (public.is_staff());

-- heatmap_blocks
drop policy if exists "hb insert" on public.heatmap_blocks;
drop policy if exists "hb update" on public.heatmap_blocks;
drop policy if exists "hb delete" on public.heatmap_blocks;
create policy "hb insert staff" on public.heatmap_blocks for insert to authenticated with check (public.is_staff());
create policy "hb update staff" on public.heatmap_blocks for update to authenticated using (public.is_staff()) with check (public.is_staff());
create policy "hb delete staff" on public.heatmap_blocks for delete to authenticated using (public.is_staff());

-- signal_blocks
drop policy if exists "sb insert" on public.signal_blocks;
drop policy if exists "sb update" on public.signal_blocks;
drop policy if exists "sb delete" on public.signal_blocks;
create policy "sb insert staff" on public.signal_blocks for insert to authenticated with check (public.is_staff());
create policy "sb update staff" on public.signal_blocks for update to authenticated using (public.is_staff()) with check (public.is_staff());
create policy "sb delete staff" on public.signal_blocks for delete to authenticated using (public.is_staff());

-- test_batches
drop policy if exists "tb insert" on public.test_batches;
drop policy if exists "tb update" on public.test_batches;
drop policy if exists "tb delete" on public.test_batches;
create policy "tb insert staff" on public.test_batches for insert to authenticated with check (public.is_staff());
create policy "tb update staff" on public.test_batches for update to authenticated using (public.is_staff()) with check (public.is_staff());
create policy "tb delete staff" on public.test_batches for delete to authenticated using (public.is_staff());

-- devices (was: anyone could insert/update/delete)
drop policy if exists "dev write" on public.devices;
create policy "dev insert staff" on public.devices for insert to authenticated with check (public.is_staff());
create policy "dev update staff" on public.devices for update to authenticated using (public.is_staff()) with check (public.is_staff());
create policy "dev delete staff" on public.devices for delete to authenticated using (public.is_staff());
